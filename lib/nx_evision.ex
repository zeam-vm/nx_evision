defmodule NxEvision do
  @moduledoc """
  `NxEvision` is a bridge
  between [Nx](https://github.com/elixir-nx/nx)
  and [evision](https://github.com/cocoa-xu/evision).
  """

  @spec convert_nx_to_mat(Nx.t(), atom) :: {:ok, reference()} | {:error, String.t()}
  def convert_nx_to_mat(t), do: convert_nx_to_mat(t, :RGB)

  def convert_nx_to_mat(nil, _), do: {:error, "tensor is nil"}

  def convert_nx_to_mat(t, colorspace) do
    {rows, cols, channels} = Nx.shape(t)

    case convert_nx_to_mat(Nx.to_binary(t), Nx.type(t), cols, rows, channels, colorspace) do
      {:ok, reference} -> {:ok, reference}
      {:error, reason} -> {:error, List.to_string(reason)}
    end
  end

  @spec convert_nx_to_mat(
          binary(),
          {atom(), pos_integer()},
          pos_integer(),
          pos_integer(),
          pos_integer(),
          atom()
        ) :: {:ok, reference()} | {:error, charlist()}
  def convert_nx_to_mat(binary, type, cols, rows, channels = 3, :RGB) do
    case OpenCV.Mat.from_binary(binary, type, cols, rows, channels) do
      {:ok, reference} ->
        case OpenCV.cvtcolor(reference, OpenCV.cv_color_rgb2bgr()) do
          {:ok, reference} -> {:ok, reference}
          {:error, reason} -> {:error, reason}
          _ -> {:error, 'unknown error when cvtcolor'}
        end

      {:error, reason} ->
        {:error, reason}

      _ ->
        {:error, 'unknown error when from_binary'}
    end
  end

  def convert_nx_to_mat(binary, type, cols, rows, channels = 4, :RGBA) do
    case OpenCV.Mat.from_binary(binary, type, cols, rows, channels) do
      {:ok, reference} ->
        case OpenCV.cvtcolor(reference, OpenCV.cv_color_rgba2bgra()) do
          {:ok, reference} -> {:ok, reference}
          {:error, reason} -> {:error, reason}
          _ -> {:error, 'unknown error when cvtcolor'}
        end

      {:error, reason} ->
        {:error, reason}

      _ ->
        {:error, 'unknown error when from_binary'}
    end
  end

  def convert_nx_to_mat(binary, type, cols, rows, channels = 3, :BGR) do
    case OpenCV.Mat.from_binary(binary, type, cols, rows, channels) do
      {:ok, reference} -> {:ok, reference}
      {:error, reason} -> {:error, reason}
      _ -> {:error, 'unknown error when from_binary'}
    end
  end

  def convert_nx_to_mat(binary, type, cols, rows, channels = 4, :BGRA) do
    case OpenCV.Mat.from_binary(binary, type, cols, rows, channels) do
      {:ok, reference} -> {:ok, reference}
      {:error, reason} -> {:error, reason}
      _ -> {:error, 'unknown error when from_binary'}
    end
  end

  @spec convert_mat_to_nx(reference, atom) :: {:ok, Nx.t()} | {:error, String.t()}

  def convert_mat_to_nx(mat), do: convert_mat_to_nx(mat, :RGB)

  def convert_mat_to_nx(nil, _), do: {:error, "reference is nil"}

  def convert_mat_to_nx(mat, :BGR) do
    case {OpenCV.Mat.type(mat), OpenCV.Mat.shape(mat), OpenCV.Mat.to_binary(mat)} do
      {{:ok, type}, {:ok, shape}, {:ok, binary}} ->
        {
          :ok,
          Nx.from_binary(binary, type) |> Nx.reshape(shape)
        }

      _ ->
        {:error, "Unknown Mat type"}
    end
  end

  def convert_mat_to_nx(mat, :BGRA), do: convert_mat_to_nx(mat, :BGR)

  def convert_mat_to_nx(mat, :RGB) do
    case OpenCV.cvtcolor(mat, OpenCV.cv_color_bgr2rgb()) do
      {:ok, reference} -> convert_mat_to_nx(reference, :BGR)
      {:error, reason} -> {:error, reason}
      _ -> {:error, "Unknown error when cvtcolor"}
    end
  end

  def convert_mat_to_nx(mat, :RGBA) do
    case OpenCV.cvtcolor(mat, OpenCV.cv_color_bgra2rgba()) do
      {:ok, reference} -> convert_mat_to_nx(reference, :BGRA)
      {:error, reason} -> {:error, reason}
      _ -> {:error, "Unknown error when cvtcolor"}
    end
  end
end
