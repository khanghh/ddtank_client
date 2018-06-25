package flowerGiving.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   
   public class FlowerGivingFrame extends Frame
   {
       
      
      private var _hBox:HBox;
      
      private var _mainPageBtn:SelectedButton;
      
      private var _todayRankBtn:SelectedButton;
      
      private var _yesRankBtn:SelectedButton;
      
      private var _cumuRankBtn:SelectedButton;
      
      private var _cumuGivingBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _view;
      
      private var currentIndex:int;
      
      public function FlowerGivingFrame()
      {
         super();
         escEnable = true;
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("flowerGiving.title");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.hBox");
         addToContent(_hBox);
         _mainPageBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.mainPageBtn");
         _hBox.addChild(_mainPageBtn);
         _todayRankBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.todayRankBtn");
         _hBox.addChild(_todayRankBtn);
         _yesRankBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.yesRankBtn");
         _hBox.addChild(_yesRankBtn);
         _cumuRankBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.cumuRankBtn");
         _hBox.addChild(_cumuRankBtn);
         _cumuGivingBtn = ComponentFactory.Instance.creatComponentByStylename("flowerGiving.cumuGivingBtn");
         _hBox.addChild(_cumuGivingBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_mainPageBtn);
         _btnGroup.addSelectItem(_todayRankBtn);
         _btnGroup.addSelectItem(_yesRankBtn);
         _btnGroup.addSelectItem(_cumuRankBtn);
         _btnGroup.addSelectItem(_cumuGivingBtn);
         _btnGroup.selectIndex = 0;
         currentIndex = 0;
         _view = new FlowerMainView();
         addToContent(_view);
      }
      
      private function addEvents() : void
      {
         addEventListener("response",_response);
         _btnGroup.addEventListener("change",__changeHandler);
      }
      
      protected function __changeHandler(event:Event) : void
      {
         if(_btnGroup.selectIndex == currentIndex)
         {
            return;
         }
         SoundManager.instance.play("008");
         ObjectUtils.disposeObject(_view);
         _view = null;
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _view = new FlowerMainView();
               break;
            case 1:
               _view = new FlowerRankView(0);
               break;
            case 2:
               _view = new FlowerRankView(1);
               break;
            case 3:
               _view = new FlowerRankView(2);
               break;
            case 4:
               _view = new FlowerSendRewardView();
         }
         currentIndex = _btnGroup.selectIndex;
         if(_view)
         {
            addToContent(_view);
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_response);
         _btnGroup.removeEventListener("change",__changeHandler);
      }
      
      private function _response(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_mainPageBtn);
         _mainPageBtn = null;
         ObjectUtils.disposeObject(_todayRankBtn);
         _todayRankBtn = null;
         ObjectUtils.disposeObject(_yesRankBtn);
         _yesRankBtn = null;
         ObjectUtils.disposeObject(_cumuRankBtn);
         _cumuRankBtn = null;
         ObjectUtils.disposeObject(_cumuGivingBtn);
         _cumuGivingBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
   }
}
