module ApplicationHelper
  def round(param)
     number_with_precision(param, precision: 1)
   end
end
