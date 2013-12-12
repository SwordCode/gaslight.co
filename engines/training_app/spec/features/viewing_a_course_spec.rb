require 'spec_helper'

feature "Viewing a course" do
  context "in person" do
    let(:parent_course) { FactoryGirl.create(:course, registration_link: "google.com") }
    let(:course_show_page) { CourseShowPage.new }

    context "with instructors" do
      let!(:instructor) { FactoryGirl.create(:instructor, courses: [parent_course]) }
      scenario "shows the instructors" do
        course_show_page.visit_page(parent_course)
        expect(course_show_page).to have_instructor_name(instructor.name)
        expect(course_show_page).to have_instructor_bio(instructor.bio)
        expect(course_show_page).to have_instructor_image(instructor.image_url)
      end
    end

    describe "viewing the registration link" do
      scenario do
        course_show_page.visit_page(parent_course)
        expect(course_show_page).to have_registration_link("google.com")
      end
    end
  end

  context "Online" do
    let(:online_course) { FactoryGirl.create(:course, online: true, description_main: "## Description", price: 199)}
    let(:course_show_page) { CourseShowPage.new }
    scenario "viewing purchase info" do
      course_show_page.visit_page(online_course)
      expect(course_show_page.buy_now_link).to eq("/training/classroom#/courses/#{online_course.id}/register")
      expect(course_show_page.price).to eq("$199")
    end
    scenario "viewing description from markdown" do
      course_show_page.visit_page(online_course)
      expect(course_show_page.description_html).to match("<h2>Description</h2>")
    end
  end
end