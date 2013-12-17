require 'spec_helper'

feature "Demoing a course", js: true do
  let(:classroom_page) { ClassroomPage.new }
  let(:course) { FactoryGirl.create(:course, online: true) }
  let!(:section) { FactoryGirl.create(:section, course: course) }

  describe "viewing restricted nav links" do
    let!(:demo_chapter) { FactoryGirl.create(:chapter, title: "Demo", demo: true, section: section) }
    let!(:restricted_chapter) { FactoryGirl.create(:chapter, title: "Restricted", section: section) }

    scenario "should be disabled" do
      classroom_page.visit_course(course)
      expect(classroom_page.disabled_chapters).to include(restricted_chapter.title)
      expect(classroom_page.disabled_chapters).to_not include(demo_chapter.title)
    end
  end

  describe "viewing a chapter" do
    context "demo chapter" do
      let(:demo_chapter) { FactoryGirl.create(:chapter, title: "Demo", demo: true, code_url: "http://example.com/") }
      scenario "should show the chapter" do
        classroom_page.visit_chapter(demo_chapter)
        expect(classroom_page.code_url).to eq("http://example.com/")
      end
    end

    context "restricted chapter" do
      let(:restricted_chapter) { FactoryGirl.create(:chapter, title: "Restricted", demo: false, code_url: "http://example.com/") }
      scenario "should show the purchase modal" do
        classroom_page.visit_course(restricted_chapter.course) #visit the course first to prevent routing error
        classroom_page.visit_chapter(restricted_chapter)
        expect(classroom_page).to be_showing_purchase_modal
      end
    end
  end
end