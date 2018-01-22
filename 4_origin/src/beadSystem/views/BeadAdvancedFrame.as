package beadSystem.views
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import road7th.data.DictionaryData;
   
   public class BeadAdvancedFrame extends Frame
   {
       
      
      private var _currentIndex:int;
      
      private var _normalBtn:SelectedButton;
      
      private var _seniorBtn:SelectedButton;
      
      private var _hBox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _view:BeadAdvancedView;
      
      public function BeadAdvancedFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      protected function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("beadSystem.beadAdvance.moduleTitleTxt");
         _view = new BeadAdvancedView();
         PositionUtils.setPos(_view,"beadSystem.beadAdvance.beadAdvanceView.Pos");
         addToContent(_view);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("bag.beadSystem.hBox");
         addToContent(_hBox);
         _normalBtn = ComponentFactory.Instance.creatComponentByStylename("bag.beadSystem.normalAdvanced");
         _hBox.addChild(_normalBtn);
         _seniorBtn = ComponentFactory.Instance.creatComponentByStylename("bag.beadSystem.seniorAdvanced");
         _hBox.addChild(_seniorBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_normalBtn);
         _btnGroup.addSelectItem(_seniorBtn);
         var _loc1_:int = 0;
         _btnGroup.selectIndex = _loc1_;
         _currentIndex = _loc1_;
         __changeHandler(null);
      }
      
      protected function addEvent() : void
      {
         _btnGroup.addEventListener("change",__changeHandler);
         PlayerManager.Instance.Self.BeadBag.addEventListener("update",__onBeadBagUpdate);
         addEventListener("response",_response);
      }
      
      private function __onBeadBagUpdate(param1:BagEvent) : void
      {
         update();
      }
      
      protected function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__changeHandler);
         PlayerManager.Instance.Self.BeadBag.removeEventListener("update",__onBeadBagUpdate);
         removeEventListener("response",_response);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      protected function __changeHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         if(_btnGroup.selectIndex < 0)
         {
            return;
         }
         var _loc2_:DictionaryData = BeadTemplateManager.Instance.getBeadAdvanceData(_btnGroup.selectIndex + 1);
         updateViewData(_loc2_,_btnGroup.selectIndex);
      }
      
      protected function updateViewData(param1:DictionaryData, param2:int) : void
      {
         if(_view)
         {
            _view.curPageIndex = param2;
            _view.update(param1);
         }
      }
      
      public function update() : void
      {
         _view.refresh();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_normalBtn)
         {
            ObjectUtils.disposeObject(_normalBtn);
         }
         _normalBtn = null;
         if(_seniorBtn)
         {
            ObjectUtils.disposeObject(_seniorBtn);
         }
         _seniorBtn = null;
         if(_hBox)
         {
            _hBox.reverChildren();
         }
         _hBox = null;
         if(_btnGroup)
         {
            ObjectUtils.disposeObject(_btnGroup);
         }
         _btnGroup = null;
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         _currentIndex = -1;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
