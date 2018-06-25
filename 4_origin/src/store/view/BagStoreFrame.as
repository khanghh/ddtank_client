package store.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpBtnEnable;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import powerUp.PowerUpMovieManager;
   import store.StoreController;
   import store.fineStore.view.FineStoreView;
   import store.forge.ForgeMainView;
   import store.newFusion.FusionNewManager;
   import store.states.BaseStoreView;
   
   public class BagStoreFrame extends Frame
   {
       
      
      private var _controller:StoreController;
      
      private var _bg:Scale9CornerImage;
      
      private var _storeBtn:SelectedButton;
      
      private var _forgeBtn:SelectedButton;
      
      private var _fineStoreBtn:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _storeView:BaseStoreView;
      
      private var _forgeView:ForgeMainView;
      
      private var _fineStoreView:FineStoreView;
      
      private var _fightPower:int;
      
      public function BagStoreFrame()
      {
         super();
         titleText = LanguageMgr.GetTranslation("tank.view.store.title");
         escEnable = true;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("newStore.mainFrame.bg");
         _storeBtn = ComponentFactory.Instance.creatComponentByStylename("newStore.tabStoreBtn");
         _forgeBtn = ComponentFactory.Instance.creatComponentByStylename("newStore.tabForgeBtn");
         _fineStoreBtn = ComponentFactory.Instance.creatComponentByStylename("newStore.tabFineStoreBtn");
         HelpBtnEnable.getInstance().addMouseOverTips(_storeBtn,5,"tips.open");
         HelpBtnEnable.getInstance().addMouseOverTips(_forgeBtn,10,"tips.open");
         HelpBtnEnable.getInstance().addMouseOverTips(_fineStoreBtn,15,"tips.open");
         addToContent(_storeBtn);
         addToContent(_forgeBtn);
         addToContent(_fineStoreBtn);
         addToContent(_bg);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_storeBtn);
         _btnGroup.addSelectItem(_forgeBtn);
         _btnGroup.addSelectItem(_fineStoreBtn);
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__changeHandler,false,0,true);
         _storeBtn.addEventListener("click",__soundPlay,false,0,true);
         _forgeBtn.addEventListener("click",__soundPlay,false,0,true);
         _fineStoreBtn.addEventListener("click",__soundPlay,false,0,true);
      }
      
      private function __changeHandler(event:Event) : void
      {
         SocketManager.Instance.out.sendClearStoreBag();
         if(_storeView)
         {
            _storeView.visible = false;
         }
         if(_forgeView)
         {
            _forgeView.visible = false;
         }
         if(_fineStoreView)
         {
            _fineStoreView.visible = false;
         }
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               if(!_storeView)
               {
                  _storeView = new BaseStoreView(_controller);
                  PositionUtils.setPos(_storeView,"ddtstore.BagStoreViewPos");
                  addToContent(_storeView);
               }
               _storeView.visible = true;
               break;
            case 1:
               if(!_forgeView)
               {
                  _forgeView = new ForgeMainView(_controller.selectedIndex["forge_store"]);
                  PositionUtils.setPos(_forgeView,"ddtstore.BagStoreViewPos");
                  addToContent(_forgeView);
               }
               _forgeView.visible = true;
               break;
            case 2:
               if(!_fineStoreView)
               {
                  _fineStoreView = new FineStoreView(_controller);
                  PositionUtils.setPos(_fineStoreView,"ddtstore.BagStoreViewPos");
                  addToContent(_fineStoreView);
               }
               if(!PlayerManager.Instance.Self.bagLocked)
               {
                  SocketManager.Instance.out.sendMoveGoods(12,0,0,-1);
               }
               _fineStoreView.visible = true;
         }
      }
      
      private function __soundPlay(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function set controller(con:StoreController) : void
      {
         _controller = con;
      }
      
      public function show(type:String) : void
      {
         _fightPower = PlayerManager.Instance.Self.FightPower;
         _controller.startupEvent();
         var _loc2_:* = type;
         if("bag_store" !== _loc2_)
         {
            if("forge_store" !== _loc2_)
            {
               if("fine_store" === _loc2_)
               {
                  _btnGroup.selectIndex = 2;
               }
            }
            else
            {
               _btnGroup.selectIndex = 1;
            }
         }
         else
         {
            _btnGroup.selectIndex = 0;
         }
         addEventListener("response",_response);
         LayerManager.Instance.addToLayer(this,3,false,1);
      }
      
      private function getStoreType(type:String) : String
      {
         if(type == "bag_store")
         {
            if(PlayerManager.Instance.Self.ConsortiaID != 0)
            {
               type = "consortia";
            }
            else
            {
               type = "general";
            }
         }
         return type;
      }
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            if(!FusionNewManager.instance.isInContinuousFusion)
            {
               dispose();
               BagStore.instance.isInBagStoreFrame = false;
               if(_fightPower < PlayerManager.Instance.Self.FightPower)
               {
                  PowerUpMovieManager.powerNum = _fightPower;
                  PowerUpMovieManager.addedPowerNum = PlayerManager.Instance.Self.FightPower - _fightPower;
                  PowerUpMovieManager.Instance.dispatchEvent(new Event("powerUp"));
               }
            }
         }
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__changeHandler);
         _storeBtn.removeEventListener("click",__soundPlay);
         _forgeBtn.removeEventListener("click",__soundPlay);
         _fineStoreBtn.removeEventListener("click",__soundPlay);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _controller.shutdownEvent();
         removeEventListener("response",_response);
         ObjectUtils.disposeObject(_storeView);
         _storeView = null;
         ObjectUtils.disposeObject(_forgeView);
         _forgeView = null;
         ObjectUtils.disposeObject(_fineStoreView);
         _fineStoreView = null;
         ObjectUtils.disposeAllChildren(this);
         _controller = null;
         if(_storeBtn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(_storeBtn);
            _storeBtn = null;
         }
         if(_forgeBtn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(_forgeBtn);
            _forgeBtn = null;
         }
         if(_fineStoreBtn)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(_fineStoreBtn);
            _fineStoreBtn = null;
         }
         _btnGroup = null;
         super.dispose();
         BagStore.instance.storeOpenAble = false;
         BagStore.instance.closed();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
