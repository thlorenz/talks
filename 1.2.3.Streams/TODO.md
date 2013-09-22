## Questions

- how do `pause/resume` work in new streams (I suppose I'd call pause in an `on('data')` handler in case I'm being
  overwhelmed by a readable?
- provide practical example of how to 'stop reading' when `self.push(chunk)` on a readable returns `false`
  [`readable._read`](http://nodejs.org/api/stream.html#stream_readable_read_size_1k)
- how often can I switch between flowing and non-flowing mode?
