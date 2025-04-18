module Views
  module Insights
    class Index < Views::Base
      def initialize(cashflow:)
        @cashflow = cashflow
      end

      private

      def view_template
        Layouts.Main do
          Bolt.Page do
            Bolt.PageHeader do
              Bolt.PageHeading do
                Bolt.PageTitle { t(".page_title") }
                Bolt.PageSubtitle { t(".page_subtitle") }
              end

              Bolt.PageActions do
                Bolt.LinkButton href: "#", color: :primary do
                  Lucide.SlidersHorizontal class: "size-4"
                  plain t(".change_period")
                end
              end
            end

            Bolt.PageBody do
              Components::Insights.CashflowCard(cashflow: @cashflow)
            end
          end
        end
      end
    end
  end
end
