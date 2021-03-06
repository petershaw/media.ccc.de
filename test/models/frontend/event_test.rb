require 'test_helper'

class EventTest < ActiveSupport::TestCase

  setup do
    @event = create(:event)
  end

  test "should find preferred recordings" do
    @event.recordings << create(:recording, mime_type: 'audio/mpeg', filename: 'audio.mp3', event: @event)
    @event.recordings << create(:recording, mime_type: 'audio/ogg', filename: 'audio.ogg', event: @event)
    @event.recordings << create(:recording, mime_type: 'video/mp4', filename: 'video.mp4', event: @event)
    @event = Frontend::Event.find(@event.id)
    assert_equal 'audio.ogg', @event.audio_recording.filename
    assert_equal 'video.mp4', @event.preferred_recording.filename
  end

  test "should not find preferred recordings" do
    @event.recordings << create(:recording, mime_type: 'video/mp4', filename: 'video.mp4', event: @event)
    @event = Frontend::Event.find(@event.id)
    assert_equal nil, @event.audio_recording
  end
end
