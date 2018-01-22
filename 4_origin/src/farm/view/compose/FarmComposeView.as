package farm.view.compose
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import petsBag.PetsBagManager;
   import store.HelpFrame;
   
   public class FarmComposeView extends Frame
   {
       
      
      private var _helpBtn:BaseButton;
      
      private var _houseBtn:SelectedButton;
      
      private var _composeBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _currentType:int = -1;
      
      private var _hosePnl:FarmHousePnl;
      
      private var _composePnl:FarmComposePnl;
      
      private var _info:SelfInfo;
      
      private var _titleBg:DisplayObject;
      
      public function FarmComposeView()
      {
         super();
         initView();
         initEvent();
         escEnable = true;
      }
      
      public function get info() : SelfInfo
      {
         return _info;
      }
      
      public function set info(param1:SelfInfo) : void
      {
         _info = param1;
      }
      
      private function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creat("assets.farmCompose.title");
         addChild(_titleBg);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("farmHouse.NotesButton");
         addToContent(_helpBtn);
         _houseBtn = ComponentFactory.Instance.creatComponentByStylename("farmShop.button.house");
         addToContent(_houseBtn);
         _composeBtn = ComponentFactory.Instance.creatComponentByStylename("farmShop.button.compose");
         addToContent(_composeBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_houseBtn);
         _btnGroup.addSelectItem(_composeBtn);
         _btnGroup.selectIndex = 0;
         _hosePnl = new FarmHousePnl();
         addToContent(_hosePnl);
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__changeHandler);
         _helpBtn.addEventListener("click",__composeHelp);
         addEventListener("response",__frameHandler);
      }
      
      private function __frameHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               if(PetsBagManager.instance().petModel.IsFinishTask5)
               {
                  PetsBagManager.instance().showPetFarmGuildArrow(113,-60,"farmTrainer.openFarmShopArrowPos","asset.farmTrainer.openFarmShop","farmTrainer.openFarmShopTipPos");
                  break;
               }
         }
      }
      
      private function __composeHelp(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("farmHouse.HelpPrompt");
         var _loc3_:HelpFrame = ComponentFactory.Instance.creat("farm.HelpFrame");
         _loc3_.setView(_loc2_);
         _loc3_.titleText = LanguageMgr.GetTranslation("ddt.farmHouse.readme");
         LayerManager.Instance.addToLayer(_loc3_,1,true,1);
      }
      
      private function __changeHandler(param1:Event) : void
      {
         SoundManager.instance.play("008");
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               switchView(true);
               break;
            case 1:
               switchView(false);
               if(PetsBagManager.instance().haveTaskOrderByID(370))
               {
                  PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(109);
                  break;
               }
         }
         _currentType = _btnGroup.selectIndex;
      }
      
      private function switchView(param1:Boolean) : void
      {
         _hosePnl.visible = param1;
         if(_composePnl == null)
         {
            _composePnl = new FarmComposePnl();
            addToContent(_composePnl);
            _composePnl.y = -15;
         }
         _composePnl.visible = !param1;
         _composePnl.clearInfo();
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__changeHandler);
         _helpBtn.removeEventListener("click",__composeHelp);
         removeEventListener("response",__frameHandler);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
         if(PetsBagManager.instance().haveTaskOrderByID(370))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(108);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _info = null;
         _currentType = -1;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
            _helpBtn = null;
         }
         if(_titleBg)
         {
            ObjectUtils.disposeObject(_titleBg);
            _titleBg = null;
         }
         if(_composePnl)
         {
            ObjectUtils.disposeObject(_composePnl);
            _composePnl = null;
         }
         if(_hosePnl)
         {
            ObjectUtils.disposeObject(_hosePnl);
            _hosePnl = null;
         }
         if(_btnGroup)
         {
            ObjectUtils.disposeObject(_btnGroup);
            _btnGroup = null;
         }
         if(_composeBtn)
         {
            ObjectUtils.disposeObject(_composeBtn);
            _composeBtn = null;
         }
         if(_houseBtn)
         {
            ObjectUtils.disposeObject(_houseBtn);
            _houseBtn = null;
         }
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
