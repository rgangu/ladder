class Player < ApplicationRecord
  belongs_to :user
  belongs_to :tournament

  has_many :ratings, dependent: :destroy
  has_many :game_ranks, dependent: :destroy
  has_many :championship_players, dependent: :destroy

  STREAK_THRESHOLD = 3

  def self.active(at = Time.zone.now)
    where('players.end_at IS NULL OR players.end_at > ?', at)
  end

  def active?(at = Time.zone.now)
    end_at.nil? || end_at > at
  end

  def streak?
    winning_streak? || losing_streak?
  end

  def winning_streak?
    winning_streak_count >= STREAK_THRESHOLD && losing_streak_count < 1
  end

  def losing_streak?
    losing_streak_count >= STREAK_THRESHOLD && winning_streak_count < 1
  end
end
