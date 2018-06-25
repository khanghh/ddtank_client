package store.forge
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpBtnEnable;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.utils.PositionUtils;
   import enchant.view.EnchantMainView;
   import equipretrieve.RetrieveFrame;
   import equipretrieve.RetrieveModel;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import gemstone.GemstoneFrame;
   import gemstone.GemstoneManager;
   import latentEnergy.LatentEnergyMainView;
   import store.forge.wishBead.WishBeadMainView;
   
   public class ForgeMainView extends Sprite implements Disposeable
   {
       
      
      private var _tabVbox:VBox;
      
      private var _tabSBG:SelectedButtonGroup;
      
      private var _tabSBList:Vector.<SelectedButton>;
      
      private var _bg:MovieClip;
      
      private var _rightBgView:ForgeRightBgView;
      
      private var _latentEnergyView:LatentEnergyMainView;
      
      private var _wishBeadView:WishBeadMainView;
      
      private var _retrieveView:RetrieveFrame;
      
      private var _gemstoneFrame:GemstoneFrame;
      
      private var _enchantFrame:EnchantMainView;
      
      private var _initIndex:int = 0;
      
      private var _openGradeList:Vector.<int>;
      
      public function ForgeMainView(index:int)
      {
         _openGradeList = new <int>[30,25,10,30,40];
         super();
         _initIndex = index;
         new HelperUIModuleLoad().loadUIModule(["forgemain"],onloadComplete);
      }
      
      private function onloadComplete() : void
      {
         initView();
         initEvent();
         setIndex();
      }
      
      private function setIndex() : void
      {
         var item:* = null;
         var i:int = 0;
         var len:int = _tabSBG.length();
         for(i = _initIndex; i < len; )
         {
            item = _tabSBG.getItemByIndex(i) as ITipedDisplay;
            if(HelpBtnEnable.getInstance().isForbidden(item) == false)
            {
               _tabSBG.selectIndex = i;
               break;
            }
            i++;
         }
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmp:* = null;
         var contentBg:DisplayObject = ComponentFactory.Instance.creatCustomObject("ddtstore.BagStoreFrame.ContentBg");
         addChild(contentBg);
         contentBg.height = 425;
         _bg = ComponentFactory.Instance.creat("asset.forgeMainView.leftBg");
         PositionUtils.setPos(_bg,"forgeMainView.leftBgPos");
         _bg.gotoAndStop(1);
         addChild(_bg);
         _rightBgView = new ForgeRightBgView();
         PositionUtils.setPos(_rightBgView,"forgeMainView.rightBgViewPos");
         addChild(_rightBgView);
         _tabVbox = ComponentFactory.Instance.creatComponentByStylename("forgeMainView.tabVBox");
         _tabSBList = new Vector.<SelectedButton>();
         _tabSBG = new SelectedButtonGroup();
         for(i = 0; i < 5; )
         {
            tmp = ComponentFactory.Instance.creatComponentByStylename("forgeMainView.tabSelectedButton" + i);
            HelpBtnEnable.getInstance().addMouseOverTips(tmp,_openGradeList[i]);
            tmp.addEventListener("click",clickHandler,false,0,true);
            _tabVbox.addChild(tmp);
            _tabSBG.addSelectItem(tmp);
            _tabSBList.push(tmp);
            i++;
         }
         addChild(_tabVbox);
      }
      
      private function initEvent() : void
      {
         _tabSBG.addEventListener("change",changeHandler,false,0,true);
      }
      
      private function clickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function changeHandler(event:Event) : void
      {
         SocketManager.Instance.out.sendClearStoreBag();
         _tabVbox.arrange();
         if(_latentEnergyView)
         {
            _latentEnergyView.visible = false;
         }
         if(_wishBeadView)
         {
            _wishBeadView.visible = false;
         }
         if(_retrieveView)
         {
            _retrieveView.visible = false;
         }
         if(_gemstoneFrame)
         {
            _gemstoneFrame.visible = false;
         }
         if(_enchantFrame)
         {
            _enchantFrame.visible = false;
         }
         switch(int(_tabSBG.selectIndex))
         {
            case 0:
               if(!_latentEnergyView)
               {
                  _latentEnergyView = new LatentEnergyMainView();
                  PositionUtils.setPos(_latentEnergyView,"forgeMainView.latentEnergyViewPos");
                  addChild(_latentEnergyView);
               }
               _latentEnergyView.visible = true;
               _rightBgView.showStoreBagViewText("forgeMainView.latentEnergy.equipTipTxt","forgeMainView.latentEnergy.itemTipTxt");
               _rightBgView.visible = true;
               _bg.gotoAndStop(1);
               break;
            case 1:
               if(!_wishBeadView)
               {
                  _wishBeadView = new WishBeadMainView();
                  PositionUtils.setPos(_wishBeadView,"forgeMainView.latentEnergyViewPos");
                  addChild(_wishBeadView);
               }
               _wishBeadView.visible = true;
               _rightBgView.showStoreBagViewText("forgeMainView.wishBead.equipTipTxt","forgeMainView.wishBead.itemTipTxt");
               _rightBgView.visible = true;
               _bg.gotoAndStop(1);
               break;
            case 2:
               ObjectUtils.disposeObject(_enchantFrame);
               _enchantFrame = null;
               if(!_retrieveView)
               {
                  RetrieveModel.Instance.start(PlayerManager.Instance.Self);
                  _retrieveView = ComponentFactory.Instance.creatCustomObject("retrieve.retrieveFrame");
                  addChild(_retrieveView);
               }
               _retrieveView.visible = true;
               _retrieveView.clearItemCell();
               _rightBgView.showStoreBagViewText("retrieveFrame.retrieve.equipTipTxt","retrieveFrame.retrieve.itemTipTxt");
               _rightBgView.visible = true;
               _bg.gotoAndStop(1);
               break;
            case 3:
               if(!_gemstoneFrame)
               {
                  _gemstoneFrame = new GemstoneFrame();
                  PositionUtils.setPos(_gemstoneFrame,"forgeMainView.gemstoneFramePos");
                  addChild(_gemstoneFrame);
                  GemstoneManager.Instance.initFrame(_gemstoneFrame);
               }
               _gemstoneFrame.visible = true;
               _rightBgView.visible = false;
               _bg.gotoAndStop(2);
               break;
            case 4:
               ObjectUtils.disposeObject(_retrieveView);
               _retrieveView = null;
               if(!_enchantFrame)
               {
                  _enchantFrame = new EnchantMainView();
                  PositionUtils.setPos(_enchantFrame,"forgeMainView.latentEnergyViewPos");
                  addChild(_enchantFrame);
               }
               _enchantFrame.visible = true;
               _rightBgView.showStoreBagViewText("forgeMainView.enchant.equipTipTxt","forgeMainView.latentEnergy.itemTipTxt");
               _rightBgView.visible = true;
               _bg.gotoAndStop(1);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         .super.visible = value;
         if(visible)
         {
            if(_latentEnergyView)
            {
               _latentEnergyView.clearCellInfo();
               _latentEnergyView.refreshListData();
            }
            if(_wishBeadView)
            {
               _wishBeadView.clearCellInfo();
               _wishBeadView.refreshListData();
            }
            if(_retrieveView)
            {
               _retrieveView.clearItemCell();
            }
            if(_tabSBG)
            {
               changeHandler(null);
            }
            if(_enchantFrame)
            {
               _enchantFrame.addUpdateStoreEvent();
            }
         }
         else
         {
            if(_enchantFrame)
            {
               _enchantFrame.removeUpdateStoreEvent();
            }
            ObjectUtils.disposeObject(_retrieveView);
            _retrieveView = null;
         }
      }
      
      private function removeEvent() : void
      {
         _tabSBG.removeEventListener("change",changeHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         var _loc3_:int = 0;
         var _loc2_:* = _tabSBList;
         for each(var tmp in _tabSBList)
         {
            HelpBtnEnable.getInstance().removeMouseOverTips(tmp);
            tmp.removeEventListener("click",clickHandler);
         }
         ObjectUtils.disposeAllChildren(this);
         _tabVbox = null;
         _tabSBG = null;
         _tabSBList = null;
         _bg = null;
         _rightBgView = null;
         _latentEnergyView = null;
         _wishBeadView = null;
         _retrieveView = null;
         _gemstoneFrame = null;
         _enchantFrame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
