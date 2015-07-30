module Sisense
  module RunOnInclude
    def included(othermod = nil, &block)
      if othermod
        othermod.instance_eval(&@_included) if @_included
      else
        @_included = block
      end
    end
  end
end