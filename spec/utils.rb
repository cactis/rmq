describe 'utils' do
  before do
    @rmq = RubyMotionQuery::RMQ
  end

  it 'should return true if class is passed to is_class?' do
    @rmq.is_class?(String).should == true
    @rmq.is_class?('hi').should == false
    FOO = :bar
    @rmq.is_class?(FOO).should == false
    @rmq.is_class?(nil).should == false
    @rmq.is_class?(UIView).should == true
  end

  it 'should return true if empty string is passed to is_blank?' do
    @rmq.is_blank?('').should == true
    @rmq.is_blank?('not blank').should == false
  end

  it 'should return true if nil is passed to is_blank?' do
    @rmq.is_blank?(nil).should == true
    @rmq.is_blank?('not nil').should == false
  end

  it 'should return true if empty array is passed to is_blank?' do
    @rmq.is_blank?([]).should == true
    @rmq.is_blank?([:not_emtpy]).should == false
  end

  it 'should return true if empty hash is passed to is_blank?' do
    @rmq.is_blank?({}).should == true
    @rmq.is_blank?({not_emtpy: true}).should == false
  end

  it 'should return a string of a view' do
    v = UIView.alloc.initWithFrame(CGRectZero)
    s = @rmq.view_to_s(v)
    s.is_a?(String) == true
    (s =~ /.*VIEW.*/).should == 1 
  end

  describe 'utils - controller_for_view' do
    it 'should return nil if view is nil' do
      @rmq.controller_for_view(nil).should == nil
    end

    it 'should return nil if a view isn\'t in a controller' do
      u = UIView.alloc.initWithFrame([[0,0],[0,0]])
      @rmq.controller_for_view(u).should == nil
    end

    it 'should return a view\'s controller' do
      controller = UIViewController.alloc.init
      root_view = controller.view
      @rmq.controller_for_view(root_view).should == controller

      sub_view = UIView.alloc.initWithFrame([[0,0],[0,0]])
      root_view.addSubview(sub_view)
      @rmq.controller_for_view(sub_view).should == controller

      sub_sub_view = UIView.alloc.initWithFrame([[0,0],[0,0]])
      sub_view.addSubview(sub_sub_view)
      @rmq.controller_for_view(sub_sub_view).should == controller
    end
  end

end
