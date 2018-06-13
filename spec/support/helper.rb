module Helpers
  # TODO rename to "assign_last_group"
  def assign_group(user, group)
    user.last_group = group
    user.save
  end

  def song_ids(songs)
    songs.map{ |s| s.id }.join(",") 
  end
end
