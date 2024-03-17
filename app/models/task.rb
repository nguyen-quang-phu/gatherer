# frozen_string_literal: true

class Task < ApplicationRecord
  attr_accessor :completed_at, :size

  def initialize(attributes)
    super(attributes)
    mark_completed(attributes[:completed_at]) if attributes.present? && attributes[:completed_at].present?
    @size = attributes.present? ? attributes[:size] : 1
  end

  def mark_completed(time = Time.current)
    @completed_at = time
  end

  def complete?
    completed_at.present?
  end

  def part_of_velocity?
    return false unless complete?

    completed_at > 3.weeks.ago
  end

  def points_toward_velocity
    part_of_velocity? ? size : 0
  end
end
