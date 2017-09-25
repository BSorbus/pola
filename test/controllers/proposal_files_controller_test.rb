require 'test_helper'

class ProposalFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proposal_file = proposal_files(:one)
  end

  test "should get index" do
    get proposal_files_url
    assert_response :success
  end

  test "should get new" do
    get new_proposal_file_url
    assert_response :success
  end

  test "should create proposal_file" do
    assert_difference('ProposalFile.count') do
      post proposal_files_url, params: { proposal_file: { load_date: @proposal_file.load_date, load_file: @proposal_file.load_file, note: @proposal_file.note, project_id: @proposal_file.project_id, status: @proposal_file.status } }
    end

    assert_redirected_to proposal_file_url(ProposalFile.last)
  end

  test "should show proposal_file" do
    get proposal_file_url(@proposal_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_proposal_file_url(@proposal_file)
    assert_response :success
  end

  test "should update proposal_file" do
    patch proposal_file_url(@proposal_file), params: { proposal_file: { load_date: @proposal_file.load_date, load_file: @proposal_file.load_file, note: @proposal_file.note, project_id: @proposal_file.project_id, status: @proposal_file.status } }
    assert_redirected_to proposal_file_url(@proposal_file)
  end

  test "should destroy proposal_file" do
    assert_difference('ProposalFile.count', -1) do
      delete proposal_file_url(@proposal_file)
    end

    assert_redirected_to proposal_files_url
  end
end
