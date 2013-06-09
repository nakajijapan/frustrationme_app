require 'spec_helper'

describe ApplicationHelper do
  describe "#icon_image_tag" do
    context 'when src is empty' do
      it 'return default image' do
        expect(icon_image_tag('')).to eq '<img alt="Icon" src="/assets/users/icon.gif" />'
      end
    end

    context 'when src exists' do
      it 'return target image' do
        expect(icon_image_tag('/assets/logo.png')).to eq '<img alt="Logo" src="/assets/logo.png" />'
      end
    end
  end
end