class WorkValidator < ActiveModel::Validator
  def validate(record)
    today_three_words = Word.today_three_words
    today_three_words.each do |tw|
      unless record.content.include? tw.name
        record.errors.add :content, "#{tw.name}が含まれていません。三つすべての言葉を含めてください"
      end
    end
  end
end