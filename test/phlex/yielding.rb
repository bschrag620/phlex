# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "yielding" do
		view do
			def template
				h2 do
          div do |d|
            yield(d)
          end
        end
			end
		end

		it "yields the inner content when passing inner_content" do
      class ::InnerContent < Phlex::HTML
        def template(&blk)
          yield_content(&blk)
        end
      end
      class ::OuterContent < Phlex::HTML
        def template(&blk)
          h2 do |h|
            render InnerContent.new do |inner_content|
              yield inner_content
            end
          end
        end
      end

      test_yield = OuterContent.new

      test_yield.call do |yielded|
        expect(yielded.class).to be == ::InnerContent
      end

		end

    it "yields the self when calling yield without arguments" do
      class ::InnerContent < Phlex::HTML
        def template(&blk)
          yield_content(&blk)
        end
      end
      class ::OuterContent < Phlex::HTML
        def template(&blk)
          h2 do |h|
            render InnerContent.new do |inner_content|
              yield
            end
          end
        end
      end

      test_yield = OuterContent.new

      test_yield.call do |yielded|
        expect(yielded.class).to be == ::OuterContent
      end

		end

    it "yields the self when using yield_content" do
      class ::InnerContent < Phlex::HTML
        def template(&blk)
          yield_content(&blk)
        end
      end
      class ::OuterContent < Phlex::HTML
        def template(&blk)
          h2 do |h|
            render InnerContent.new do |inner_content|
              yield_content(&blk)
            end
          end
        end
      end

      test_yield = OuterContent.new

      test_yield.call do |yielded|
        expect(yielded.class).to be == ::OuterContent
      end

		end
	end
end
