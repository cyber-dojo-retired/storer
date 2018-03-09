require_relative 'test_base'
require_relative 'spy_logger'
require_relative '../../src/all_avatars_names'

class StorerTest < TestBase

  def self.hex_prefix
    'E4FDA'
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -
  # path
  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '218',
  'path is set to ENV[CYBER_DOJO_KATAS_ROOT] from docker-compose.yml' do
    assert_equal cyber_dojo_katas_root, storer.path
    assert_equal '/tmp/cyber-dojo/katas', storer.path
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -
  # kata_exists? never raises
  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '6B7',
  'kata_exists? is false for invalid kata_id' do
    invalid_kata_ids.each do |invalid_id|
      refute kata_exists?(invalid_id), invalid_id
    end
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -
  # avatar_exists? never raises
  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '78E',
  'avatar_exists? is false for invalid kata_id' do
    invalid_kata_ids.each do |invalid_id|
      refute avatar_exists?(invalid_id, 'dolphin'), invalid_id
    end
  end

  test '78F',
  'avatar_exists? is false for invalid avatar_name' do
    manifest = create_manifest
    kata_id = manifest['id']
    invalid_avatar_names.each do |invalid_name|
      refute avatar_exists?(kata_id, invalid_name), invalid_name
    end
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -
  # invalid kata_id raises on any other method
  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'AC2',
  'kata_manifest() with invalid kata_id raises' do
    assert_invalid_kata_id_raises { |invalid_id|
      kata_manifest(invalid_id)
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '965',
  'started_avatars() with invalid kata_id raises' do
    assert_invalid_kata_id_raises { |invalid_id|
      started_avatars(invalid_id)
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '5DF',
  'start_avatar() with invalid kata_id raises' do
    assert_bad_kata_id_raises { |invalid_id|
      start_avatar(invalid_id, [lion])
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'D9F',
  'avatar_increments() with invalid kata_id raises' do
    assert_bad_kata_id_raises { |invalid_id|
      avatar_increments(invalid_id, lion)
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '160',
  'avatar_visible_files() with invalid kata_id raises' do
    assert_bad_kata_id_raises { |invalid_id|
      avatar_visible_files(invalid_id, lion)
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'D46',
  'avatar_ran_tests() with invalid kata_id raises' do
    assert_bad_kata_id_raises { |invalid_id|
      args = [
        invalid_id,
        lion,
        starting_files,
        time_now,
        output,
        red
      ]
      avatar_ran_tests(*args)
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '917',
  'tag_visible_files() with invalid kata_id raises' do
    assert_bad_kata_id_raises { |invalid_id|
      tag_visible_files(invalid_id, lion, tag=3)
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '918',
  'tags_visible_files() with invalid kata_id raises' do
    assert_bad_kata_id_raises { |invalid_id|
      tags_visible_files(invalid_id, lion, was_tag=2, now_tag=3)
    }
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # invalid avatar-name on any other method raises
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'B5F',
  'avatar_increments() with invalid avatar_name raises' do
    assert_invalid_avatar_raises { |kata_id, invalid_avatar_name|
      avatar_increments(kata_id, invalid_avatar_name)
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '679',
  'avatar_visible_files() with invalid avatar_name raises' do
    assert_invalid_avatar_raises { |kata_id, invalid_avatar_name|
      avatar_visible_files(kata_id, invalid_avatar_name)
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '941',
  'avatar_ran_tests() with invalid avatar_name raises' do
    assert_invalid_avatar_raises { |kata_id, invalid_avatar_name|
      args = [
        kata_id,
        invalid_avatar_name,
        starting_files,
        time_now,
        output,
        red
      ]
      avatar_ran_tests(*args)
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '394',
  'avatar_ran_test() with non-existent avatar_name raises' do
    assert_invalid_avatar_raises { |kata_id, _invalid_avatar_name|
      args = [
        kata_id,
        lion, # valid but does not exist
        starting_files,
        time_now,
        output,
        red
      ]
      avatar_ran_tests(*args)
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -
  #TODO other methods...
  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # invalid tag on any method raises
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '381',
  'tag_visible_files() with invalid tag raises' do
    assert_bad_tag_raises { |valid_id, valid_name, bad_tag|
      tag_visible_files(valid_id, valid_name, bad_tag)
    }
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '382',
  'tags_visible_files() with invalid tag raises' do
    assert_bad_tag_pair_raises { |valid_id, valid_name, was_tag, now_tag|
      tags_visible_files(valid_id, valid_name, was_tag, now_tag)
    }
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # create_kata
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'B99',
  'after create_kata(manifest) manifest has only stored properties' do
    id = make_kata
    manifest = kata_manifest(id)
    expected = %w(
      id
      created
      display_name
      exercise
      filename_extension
      image_name
      runner_choice
      visible_files
    )
    assert_equal expected.sort, manifest.keys.sort
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # start_avatar
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'A6B',
  'before starting an avatar none exist' do
    id = make_kata
    assert_equal([], started_avatars(id))
    assert_equal({}, kata_increments(id))
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'F6E',
  'rogue sub-dirs in kata-dir are not reported as avatars' do
    id = make_kata
    rogue = 'flintstone'
    disk[kata_path(id) + '/' + rogue].make
    assert_equal [rogue], disk[kata_path(id)].each_dir.collect { |name| name }
    assert_equal [], started_avatars(id)
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'CBF',
  'avatar_start(not-an-avatar-name) is nil' do
    id = make_kata
    assert_nil start_avatar(id, ['pencil'])
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'E0C', %w(
    after avatar_starts;
    avatar has no traffic-lights,
    avatar's visible_files are from the kata,
    avatar's increments already have tag zero
  ) do
    id = make_kata
    assert_equal lion, start_avatar(id, [lion])
    assert_equal [lion], started_avatars(id)
    expected_filenames = %w(
      cyber-dojo.sh
      hiker.h
      hiker.c
      hiker.tests.c
      instructions
      makefile
      output
    ).sort
    assert_equal expected_filenames, avatar_visible_files(id, lion).keys.sort
    assert_equal expected_filenames, tag_visible_files(id, lion, tag=0).keys.sort
    tag0 =
    {
      'event'  => 'created',
      'time'   => creation_time,
      'number' => 0
    }
    assert_equal [tag0], avatar_increments(id, lion)
    assert_equal( { lion => [tag0] }, kata_increments(id))

    assert_equal tiger, start_avatar(id, [tiger])
    assert_equal [lion,tiger].sort, started_avatars(id).sort
    assert_equal [tag0], avatar_increments(id, tiger)
    assert_equal( { lion => [tag0], tiger => [tag0] }, kata_increments(id))
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test 'B1C',
  'avatar_start succeeds 64 times then kata is full' do
    id = make_kata
    all_avatars_names.size.times do
      start_avatar(id, all_avatars_names)
    end
    assert_equal all_avatars_names.sort, started_avatars(id).sort
    assert_nil start_avatar(id, all_avatars_names)
  end

  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # ran_tests
  #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '3CF', %w(
    after ran_tests() there is one more tag, one more traffic-light;
    visible_files are retrievable by implicit current-tag,
    visible_files are retrievable by explicit tag
  ) do
    kata_id = make_kata(starting_files)
    start_avatar(kata_id, [lion])
    was_tag = 0

    storer.avatar_ran_tests(*make_args(kata_id, edited_files))
    now_tag = 1

    # traffic-lights
    expected = [
      { 'event'  => 'created',
        'time'   => creation_time,
        'number' => was_tag
      },
      { 'colour' => red,
        'time'   => time_now,
        'number' => now_tag
      }
    ]
    assert_equal expected, avatar_increments(kata_id, lion)
    assert_equal({ lion => expected }, kata_increments(kata_id))
    # current tag
    visible_files = avatar_visible_files(kata_id, lion)
    assert_equal output, visible_files['output'], 'output'
    edited_files.each do |filename,content|
      assert_equal content, visible_files[filename], filename
    end
    # was_tag
    was_tag_visible_files = tag_visible_files(kata_id, lion, was_tag)
    refute was_tag_visible_files.keys.include?('output')
    starting_files.each do |filename,content|
      assert_equal content, was_tag_visible_files[filename], filename
    end
    # now_tag
    now_tag_visible_files = tag_visible_files(kata_id, lion, now_tag)
    assert_equal output, now_tag_visible_files['output'], 'output'
    edited_files.each do |filename,content|
      assert_equal content, now_tag_visible_files[filename], filename
    end
    # both tags at once
    hash = tags_visible_files(kata_id, lion, was_tag, now_tag)
    assert_hash_equal was_tag_visible_files, hash['was_tag']
    assert_hash_equal now_tag_visible_files, hash['now_tag']
  end

  # - - - - - - - - - - - - - - - - - - - - - - - - - -
  # tag_visible_files
  # test-data: 420B05BA0A, dolphin, 20 rags
  # - - - - - - - - - - - - - - - - - - - - - - - - - -

  test '170',
  %w( tag_visible_files with valid +ve tag ) do
    visible_files = storer.tag_visible_files('420B05BA0A', 'dolphin', 20)
    expected = %w(
      Calcolatrice.java
      HikerTest.java
      cyber-dojo.sh
      instructions
      output
    )
    assert_equal expected.sort, visible_files.keys.sort
  end

  test '171',
  %w( tag_visible_files with -1 tag is last tag ) do
    visible_files = storer.tag_visible_files('420B05BA0A', 'dolphin', -1)
    expected = %w(
      Calcolatrice.java
      HikerTest.java
      cyber-dojo.sh
      instructions
      output
    )
    assert_equal expected.sort, visible_files.keys.sort
  end

  test '172',
  %w( tag_visible_files raises when kata_id is invalid ) do
    error = assert_raises(ArgumentError) {
      storer.tag_visible_files('xxx', 'dolphin', 20)
    }
    assert_equal 'invalid kata_id', error.message
  end

  test '173',
  %w( tag_visible_files raises when avatar_name is invalid ) do
    error = assert_raises(ArgumentError) {
      storer.tag_visible_files('420B05BA0A', 'xxx', 20)
    }
    assert_equal 'invalid avatar_name', error.message
  end

  test '174',
  %w( tag_visible_files raises when tag is invalid ) do
    error = assert_raises(ArgumentError) {
      storer.tag_visible_files('420B05BA0A', 'dolphin', 21)
    }
    assert_equal 'invalid tag', error.message
  end

  private # = = = = = = = = = = = = = = = = = = = = = = =

  include AllAvatarsNames

  def lion
    'lion'
  end

  def tiger
    'tiger'
  end

  def edited_files
    { 'cyber-dojo.sh' => 'gcc',
      'hiker.c'       => '#include "hiker.h"',
      'hiker.h'       => '#ifndef HIKER_INCLUDED',
      'hiker.tests.c' => '#include <assert.h>'
    }
  end

  def make_args(id, files)
    [ id, lion, files, time_now, output, red ]
  end

  def time_now
    [2016, 12, 2, 6, 14, 57]
  end

  def output
    'Assertion failed: answer() == 42'
  end

  def red
    'red'
  end

  # - - - - - - - - - - - - - - - - - - - - - - - -

  def avatar_path(name)
    path_join(kata_path, name)
  end

  def kata_path(kata_id)
    path_join(storer.path, outer(kata_id), inner(kata_id))
  end

  def path_join(*args)
    File.join(*args)
  end

  # - - - - - - - - - - - - - - - - - - - - - - - -

  def assert_bad_kata_id_raises
    valid_but_no_kata = 'F6316A5C7C'
    (invalid_kata_ids + [ valid_but_no_kata ]).each do |bad_id|
      error = assert_raises(ArgumentError) { yield bad_id }
      assert_invalid_kata_id(error)
    end
  end

  def assert_invalid_kata_id_raises
    invalid_kata_ids.each do |invalid_id|
      error = assert_raises(ArgumentError) { yield invalid_id }
      assert_invalid_kata_id(error)
    end
  end

  def invalid_kata_ids
    [
      nil,          # not an object
      [],           # not a string
      '',           # not 10 chars
      '34',         # not 10 chars
      '345',        # not 10 chars
      '123456789',  # not 10 chars
      'ABCDEF123X'  # not 10 hex chars
    ]
  end

  def assert_invalid_kata_id(error)
    assert invalid?(error, 'kata_id'), error.message
  end

  # - - - - - - - - - - - - - - - - - - - - - - - -

  def assert_invalid_avatar_raises
    id = make_kata
    invalid_avatar_names.each do |invalid_name|
      error = assert_raises(ArgumentError) {
        yield id, invalid_name
      }
      assert invalid?(error, 'avatar_name'), error.message
    end
  end

  def invalid_avatar_names
    [
      nil,     # not an object
      [],      # not a string
      '',      # not a name
      'blurb', # not a name
      'dolpin' # not a name (dolphin has an H)
    ]
  end

  # - - - - - - - - - - - - - - - - - - - - - - - -

  def assert_bad_tag_raises
    id = make_kata
    storer.start_avatar(id, [lion])
    bad_tags.each do |bad_tag|
      error = assert_raises(ArgumentError) {
        yield id, lion, bad_tag
      }
      assert invalid?(error, 'tag'), error.message
    end
  end

  def bad_tags
    [ nil, [], 'sunglasses', 999 ]
  end

  # - - - - - - - - - - - - - - - - - - - - - - - -

  def assert_bad_tag_pair_raises
    id = make_kata
    storer.start_avatar(id, [lion])
    bad_tag_pairs.each do |was_tag, now_tag|
      error = assert_raises(ArgumentError) {
        yield id, lion, was_tag, now_tag
      }
      assert invalid?(error, 'tag'), error.message
    end
  end

  def bad_tag_pairs
    [
      [nil,nil],
      [nil,[]],
      [nil,'sunglasses'],
      [nil,999],
      [0,nil],
      [0,[]],
      [0,'pen'],
      [0,999]
    ]
  end

  # - - - - - - - - - - - - - - - - - - - - - - - -

  def invalid?(error, name)
    error.message.end_with?("invalid #{name}")
  end

end
