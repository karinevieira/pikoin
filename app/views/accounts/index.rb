module Views
  module Accounts
    class Index < Views::Base
      def initialize(accounts:)
        @accounts = accounts
      end

      private

      def view_template
        Layouts.Main do
          Bolt.Page do
            Bolt.PageHeader do
              Bolt.PageHeading do
                Bolt.PageTitle do
                  t("Accounts")
                end

                Bolt.PageSubtitle do
                  t("View and manage your accounts")
                end
              end

              if @accounts.any?
                Bolt.PageActions do
                  Bolt.LinkButton href: new_account_path, color: :primary do
                    Lucide.Plus class: "size-4"
                    plain t("New account")
                  end
                end
              end
            end

            Bolt.PageBody do
              if @accounts.any?
                Components::Accounts.List(accounts: @accounts)
              else
                Components::Accounts.EmptyState
              end
            end
          end
        end
      end
    end
  end
end
