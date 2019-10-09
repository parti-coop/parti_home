unless Rails.env.test?
  ActiveSupport.on_load :active_record do
    module AbstractMysqlAdapterWithInnodbRowFormat
      def create_table(table_name, options = {})
        if options[:options].present?
          upppder_options = options[:options].upcase
          if upppder_options.include?("DEFAULT CHARSET=") or
              upppder_options.include?("COLLATE=") or
              upppder_options.include?("ROW_FORMAT=")
            abort "DEFAULT CHARSET / COLLATE / ROW_FORMAT options을 지정할 수 없습니다. 마이그레이션을 중단합니다."
          end
        end
        table_options = options.merge(:options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC')
        super(table_name, table_options) do |td|
          yield td if block_given?
        end
      end
    end
    ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter.send(:prepend, AbstractMysqlAdapterWithInnodbRowFormat)
  end
end
