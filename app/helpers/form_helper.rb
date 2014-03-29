module FormHelper
  ActionView::Helpers::FormBuilder.class_eval do
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper
    include ActionView::Context

    def bs_text_field *input
      bs_field *input.unshift(:text_field)
    end

    def bs_text_area *input
      bs_field *input.unshift(:text_area)
    end

    def bs_select *input
      bs_field *input.unshift(:select)
    end

    def bs_field *input
      extra = input.last.is_a?(Hash) && input.last[:extra] ? input.pop[:extra] : {}
      column = input[1]
      errors = object.errors[column]
      content_tag(:div, class: "form-group #{'has-error' if errors.any?}") do
        content = self.label column, extra[:label], class: "control-label"
        content += self.send *input + [class: "form-control #{extra[:input_class]}"]
        content += content_tag :span, errors.join(", "), class: "help-block error"
        content
      end
    end

    def bs_checkbox(column, opts = {})
      extra = opts[:extra] ? opts[:extra] : {}
      content_tag(:div, class: "checkbox") do
        self.label column, class: "control-label" do
          self.check_box(column) + (extra[:label] || column.to_s.humanize)
        end
      end
    end


  end

end
