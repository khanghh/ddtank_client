package store.fineStore.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.HelpBtnEnable;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import store.FineBringUpController;
   import store.StoreController;
   import store.fineStore.view.pageBringUp.FineBringUpView;
   import store.fineStore.view.pageBringUp.evolution.FineEvolutionView;
   import store.fineStore.view.pageForge.FineForgeView;
   
   public class FineStoreView extends Sprite implements Disposeable
   {
      
      private static const _forgeGroupType:Array = ["storeFineForge","storeFineBringUp","equipGhost","storeFineForge"];
       
      
      private var _tabVbox:VBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _forgeBtn:SelectedButton;
      
      private var _forgeView:FineForgeView;
      
      private var _bringUpBtn:SelectedButton;
      
      private var _bringUpView:FineBringUpView;
      
      private var _evolutionBtn:SelectedButton;
      
      private var _evolutionView:FineEvolutionView;
      
      private var _ghostBtn:SelectedButton;
      
      private var _ghostView:FineGhostView;
      
      private var _content:Sprite;
      
      private var _index:int;
      
      private var _controller:StoreController;
      
      public function FineStoreView(controller:StoreController)
      {
         super();
         _controller = controller;
         init();
         setIndex();
      }
      
      private function setIndex() : void
      {
         var item:* = null;
         var i:int = 0;
         var len:int = _btnGroup.length();
         for(i = _index; i < len; )
         {
            item = _btnGroup.getItemByIndex(i) as ITipedDisplay;
            if(HelpBtnEnable.getInstance().isForbidden(item) == false)
            {
               _btnGroup.selectIndex = i;
               break;
            }
            i++;
         }
      }
      
      private function init() : void
      {
         var contentBg:DisplayObject = ComponentFactory.Instance.creatCustomObject("ddtstore.BagStoreFrame.ContentBg");
         addChild(contentBg);
         contentBg.height = 425;
         _content = new Sprite();
         addChild(_content);
         _forgeBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.fineStore.forgeBtn");
         _bringUpBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.fineStore.bringUpBtn");
         _evolutionBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.fineStore.evolutionBtn");
         _ghostBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.equipGhost.ghost");
         HelpBtnEnable.getInstance().addMouseOverTips(_forgeBtn,35);
         HelpBtnEnable.getInstance().addMouseOverTips(_bringUpBtn,15);
         HelpBtnEnable.getInstance().addMouseOverTips(_evolutionBtn,50);
         HelpBtnEnable.getInstance().addMouseOverTips(_ghostBtn,40);
         _tabVbox = ComponentFactory.Instance.creatComponentByStylename("ddtstore.BagStoreFrame.TabSelectedBtnContainer");
         PositionUtils.setPos(_tabVbox,"ddtstore.FineStore.VboxPos");
         addChild(_tabVbox);
         _tabVbox.addChild(_forgeBtn);
         _tabVbox.addChild(_bringUpBtn);
         _tabVbox.addChild(_ghostBtn);
         _tabVbox.addChild(_evolutionBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addEventListener("change",__changeHandler,false,0,true);
         _btnGroup.addSelectItem(_forgeBtn);
         _btnGroup.addSelectItem(_bringUpBtn);
         _btnGroup.addSelectItem(_ghostBtn);
         _btnGroup.addSelectItem(_evolutionBtn);
      }
      
      private function __changeHandler(event:Event) : void
      {
         SoundManager.instance.playButtonSound();
         var type:String = _forgeGroupType[_btnGroup.selectIndex];
         _tabVbox.arrange();
         AssetModuleLoader.addModelLoader(type,6);
         AssetModuleLoader.startCodeLoader(showView);
      }
      
      private function showView() : void
      {
         if(_forgeView)
         {
            _forgeView.visible = false;
         }
         if(_evolutionView)
         {
            _evolutionView.visible = false;
         }
         if(_ghostView)
         {
            _ghostView.visible = false;
         }
         if(_bringUpView)
         {
            ObjectUtils.disposeObject(_bringUpView);
            _bringUpView = null;
            FineBringUpController.getInstance().dispose();
            SocketManager.Instance.out.sendClearStoreBag();
         }
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               if(!_forgeView)
               {
                  _forgeView = new FineForgeView();
                  PositionUtils.setPos(_forgeView,"ddtstore.FineStore.ItemViewPos");
                  _content.addChild(_forgeView);
               }
               _forgeView.visible = true;
               if(_evolutionView)
               {
                  _evolutionView.removeEvent();
               }
               break;
            case 1:
               if(!_bringUpView)
               {
                  _bringUpView = new FineBringUpView();
                  PositionUtils.setPos(_bringUpView,"ddtstore.FineStore.ItemViewPos");
                  _content.addChild(_bringUpView);
                  FineBringUpController.getInstance().setup(_bringUpView);
               }
               FineBringUpController.getInstance().usingLock = false;
               SocketManager.Instance.out.sendClearStoreBag();
               _bringUpView.refreshBagList();
               _bringUpView.visible = true;
               if(_evolutionView)
               {
                  _evolutionView.removeEvent();
               }
               break;
            case 2:
               SocketManager.Instance.out.sendClearStoreBag();
               if(!_ghostView)
               {
                  _ghostView = new FineGhostView(_controller);
                  PositionUtils.setPos(_ghostView,"ddtstore.FineStore.ghostViewPos");
                  _content.addChild(_ghostView);
               }
               _ghostView.show();
               break;
            case 3:
               if(!_evolutionView)
               {
                  _evolutionView = new FineEvolutionView(_controller);
                  _content.addChild(_evolutionView);
               }
               _evolutionView.initEvent();
               FineBringUpController.getInstance().usingLock = false;
               SocketManager.Instance.out.sendClearStoreBag();
               _evolutionView.visible = true;
         }
      }
      
      public function dispose() : void
      {
         FineBringUpController.getInstance().dispose();
         _controller = null;
         _bringUpBtn && HelpBtnEnable.getInstance().removeMouseOverTips(_bringUpBtn);
         _forgeBtn && HelpBtnEnable.getInstance().removeMouseOverTips(_forgeBtn);
         _evolutionBtn && HelpBtnEnable.getInstance().removeMouseOverTips(_evolutionBtn);
         _ghostBtn && HelpBtnEnable.getInstance().removeMouseOverTips(_ghostBtn);
         _btnGroup.removeEventListener("change",__changeHandler);
         _btnGroup.dispose();
         ObjectUtils.disposeAllChildren(_content);
         ObjectUtils.disposeAllChildren(this);
         _btnGroup = null;
         _tabVbox = null;
      }
   }
}
