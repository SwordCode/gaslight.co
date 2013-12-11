require 'spec_helper'

module TrainingApp
  describe ChapterSerializer do
    let(:registration) { FactoryGirl.create(:registration) }
    let(:chapter) { FactoryGirl.create(:chapter, video_url: "test", code_url: "jsbin.com")}
    let(:demo_chapter) { FactoryGirl.create(:chapter, video_url: "test", code_url: "jsbin.com", demo: true)}

    context "with a registration" do
      let(:serializer){ ChapterSerializer.new(chapter, scope: registration, scope_name: "registration") }
      it "should include urls" do
        expect(serializer.attributes[:video_url]).to be_present
      end
    end

    context "without a registration" do
      let(:serializer){ ChapterSerializer.new(chapter, scope: nil, scope_name: "registration") }
      it "should remove urls" do
        expect(serializer.attributes[:video_url]).to be_blank
        expect(serializer.attributes[:description]).to be_blank
      end
    end

    context "when demo" do
      let(:serializer){ ChapterSerializer.new(demo_chapter, scope: nil, scope_name: "registration") }
      it "should include urls" do
        expect(serializer.attributes[:video_url]).to be_present
      end
    end
  end
end