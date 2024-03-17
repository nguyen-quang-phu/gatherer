# frozen_string_literal: true

class Project < ApplicationRecord
  attr_accessor :tasks, :due_date

  def initialize(attributes = {})
    super(attributes)
    @tasks = []
  end

  def done?
    tasks.all?(&:complete?)
  end

  def total_size
    tasks.sum(&:size)
  end

  def incomplete_tasks
    tasks.reject(&:complete?)
  end

  def remaining_size
    incomplete_tasks.sum(&:size)
  end

  def completed_velocity
    tasks.sum(&:points_toward_velocity)
  end

  def current_rate
    completed_velocity * 1.0 / 21
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def on_schedule?
    return false if projected_days_remaining.nan?

    (Date.current + projected_days_remaining) <= due_date
  end
end
