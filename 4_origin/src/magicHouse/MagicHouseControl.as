package magicHouse
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.BagInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.view.bossbox.AwardsView;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class MagicHouseControl extends EventDispatcher
   {
      
      private static var _instance:MagicHouseControl;
       
      
      private var _magicHouseMainView:MagicHouseMainView;
      
      public function MagicHouseControl(param1:MagicHouseInstance)
      {
         super();
      }
      
      public static function get instance() : MagicHouseControl
      {
         if(_instance == null)
         {
            _instance = new MagicHouseControl(new MagicHouseInstance());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         MagicHouseManager.instance.addEventListener("showMainView",__showHandler);
         MagicHouseManager.instance.addEventListener("hideMainView",__hideHandler);
         MagicHouseManager.instance.addEventListener("freebox_return",__freeBoxReturnHandler);
         MagicHouseManager.instance.addEventListener("chargebox_return",__chargeBoxReturnHandler);
      }
      
      private function __showHandler(param1:Event) : void
      {
         if(PlayerManager.Instance.Self.Grade >= 17)
         {
            _magicHouseMainView = ComponentFactory.Instance.creatComponentByStylename("magicHouse.mainViewFrame");
            _magicHouseMainView.show(MagicHouseModel.instance.viewIndex);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",17));
         }
      }
      
      private function __hideHandler(param1:Event) : void
      {
         if(_magicHouseMainView)
         {
            _magicHouseMainView.close();
         }
      }
      
      private function __freeBoxReturnHandler(param1:Event) : void
      {
         var _loc6_:* = null;
         var _loc5_:AwardsView = new AwardsView();
         _loc5_.goodsList = MagicHouseModel.instance.freeBoxGoodListInfos;
         _loc5_.boxType = 4;
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creat("magichouse.collectionView.boxGetAwards");
         _loc4_.text = LanguageMgr.GetTranslation("ddt.bagandinfo.awardsTitle");
         _loc4_.x = 80;
         _loc6_ = ComponentFactory.Instance.creatComponentByStylename("magichouse.ItemPreviewListFrame");
         var _loc3_:String = LanguageMgr.GetTranslation("magichouse.collectionView.freeBoxItemName");
         var _loc2_:AlertInfo = new AlertInfo(_loc3_);
         _loc2_.showCancel = false;
         _loc2_.moveEnable = false;
         _loc6_.info = _loc2_;
         _loc6_.addToContent(_loc5_);
         _loc6_.addToContent(_loc4_);
         _loc6_.addEventListener("response",__frameClose);
         LayerManager.Instance.addToLayer(_loc6_,3,true,1);
      }
      
      private function __chargeBoxReturnHandler(param1:Event) : void
      {
         var _loc6_:* = null;
         var _loc5_:AwardsView = new AwardsView();
         _loc5_.goodsList = MagicHouseModel.instance.chargeBoxGoodListInfos;
         _loc5_.boxType = 4;
         var _loc4_:FilterFrameText = ComponentFactory.Instance.creat("magichouse.collectionView.boxGetAwards");
         _loc4_.text = LanguageMgr.GetTranslation("ddt.bagandinfo.awardsTitle");
         _loc4_.x = 80;
         _loc6_ = ComponentFactory.Instance.creatComponentByStylename("magichouse.ItemPreviewListFrame");
         var _loc3_:String = LanguageMgr.GetTranslation("magichouse.collectionView.chargeBoxItemName");
         var _loc2_:AlertInfo = new AlertInfo(_loc3_);
         _loc2_.showCancel = false;
         _loc2_.moveEnable = false;
         _loc6_.info = _loc2_;
         _loc6_.addToContent(_loc5_);
         _loc6_.addToContent(_loc4_);
         _loc6_.addEventListener("response",__frameClose);
         LayerManager.Instance.addToLayer(_loc6_,3,true,1);
      }
      
      private function __frameClose(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _loc2_.removeEventListener("response",__frameClose);
               _loc2_.dispose();
               SocketManager.Instance.out.sendClearStoreBag();
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.collectionView.getBoxAwardMessage"));
         }
      }
      
      public function initServerConfig() : void
      {
         MagicHouseModel.instance.juniorWeaponList = ServerConfigManager.instance.magicHouseJuniorWeaponList;
         MagicHouseModel.instance.midWeaponList = ServerConfigManager.instance.magicHouseMidWeaponList;
         MagicHouseModel.instance.seniorWeapinList = ServerConfigManager.instance.magicHouseSeniorWeaponList;
         MagicHouseModel.instance.boxNeedmoney = ServerConfigManager.instance.magicHouseBoxNeedMonry;
         MagicHouseModel.instance.openDepotNeedMoney = ServerConfigManager.instance.magicHouseOpenDepotNeedMoney;
         MagicHouseModel.instance.levelUpNumber = ServerConfigManager.instance.magicHouseLevelUpNumber;
         MagicHouseModel.instance.depotPromoteNeedMoney = ServerConfigManager.instance.magicHouseDepotPromoteNeedMoney;
         MagicHouseModel.instance.juniorAddAttribute = ServerConfigManager.instance.magicHouseJuniorAddAttribute;
         MagicHouseModel.instance.midAddAttribute = ServerConfigManager.instance.magicHouseMidAddAttribute;
         MagicHouseModel.instance.seniorAddAttribute = ServerConfigManager.instance.magicHouseSeniorAddAttribute;
      }
      
      public function selectEquipFromBag() : void
      {
         var _loc6_:int = 0;
         var _loc1_:Boolean = false;
         var _loc9_:* = null;
         var _loc11_:int = 0;
         var _loc14_:* = null;
         var _loc5_:int = 0;
         var _loc10_:* = null;
         var _loc15_:int = 0;
         var _loc13_:* = null;
         var _loc2_:int = 0;
         var _loc8_:* = null;
         var _loc7_:int = 0;
         var _loc12_:* = null;
         var _loc3_:int = 0;
         var _loc4_:BagInfo = PlayerManager.Instance.Self.Bag;
         if(MagicHouseModel.instance.equipOpenList == null)
         {
            MagicHouseModel.instance.equipOpenList = [];
         }
         _loc6_ = 0;
         while(_loc6_ < 9)
         {
            _loc1_ = false;
            if(_loc6_ < 3)
            {
               _loc9_ = MagicHouseModel.instance.juniorWeaponList[_loc6_].split(",");
               _loc11_ = 0;
               while(_loc11_ < _loc9_.length)
               {
                  _loc14_ = _loc4_.findItemsByTempleteID(_loc9_[_loc11_]);
                  _loc5_ = 0;
                  while(_loc5_ < _loc14_.length)
                  {
                     if(_loc14_[_loc5_] != null && _loc14_[_loc5_].getRemainDate() > 0)
                     {
                        _loc1_ = true;
                        break;
                     }
                     _loc5_++;
                  }
                  if(!_loc1_)
                  {
                     _loc11_++;
                     continue;
                  }
                  break;
               }
               MagicHouseModel.instance.equipOpenList[_loc6_] = _loc1_;
            }
            else if(_loc6_ < 6)
            {
               _loc10_ = MagicHouseModel.instance.midWeaponList[_loc6_ - 3].split(",");
               _loc15_ = 0;
               while(_loc15_ < _loc10_.length)
               {
                  _loc13_ = _loc4_.findItemsByTempleteID(_loc10_[_loc15_]);
                  _loc2_ = 0;
                  while(_loc2_ < _loc13_.length)
                  {
                     if(_loc13_[_loc2_] != null && _loc13_[_loc2_].getRemainDate() > 0)
                     {
                        _loc1_ = true;
                        break;
                     }
                     _loc2_++;
                  }
                  if(!_loc1_)
                  {
                     _loc15_++;
                     continue;
                  }
                  break;
               }
               MagicHouseModel.instance.equipOpenList[_loc6_] = _loc1_;
            }
            else
            {
               _loc8_ = MagicHouseModel.instance.seniorWeapinList[_loc6_ - 6].split(",");
               _loc7_ = 0;
               while(_loc7_ < _loc8_.length)
               {
                  _loc12_ = _loc4_.findItemsByTempleteID(_loc8_[_loc7_]);
                  _loc3_ = 0;
                  while(_loc3_ < _loc12_.length)
                  {
                     if(_loc12_[_loc3_] != null && _loc12_[_loc3_].getRemainDate() > 0)
                     {
                        _loc1_ = true;
                        break;
                     }
                     _loc3_++;
                  }
                  if(!_loc1_)
                  {
                     _loc7_++;
                     continue;
                  }
                  break;
               }
               MagicHouseModel.instance.equipOpenList[_loc6_] = _loc1_;
            }
            _loc6_++;
         }
      }
      
      public function checkGetFreeBoxTime() : Boolean
      {
         if(MagicHouseModel.instance.freeGetTime.getDate() != TimeManager.Instance.Now().getDate())
         {
            return true;
         }
         return false;
      }
      
      public function chechGetChargeBoxTime() : Boolean
      {
         if(MagicHouseModel.instance.chargeGetTime.getDate() != TimeManager.Instance.Now().getDate())
         {
            return true;
         }
         return false;
      }
      
      public function closeMagicHouseView() : void
      {
         if(_magicHouseMainView)
         {
            _magicHouseMainView.close();
         }
      }
   }
}

class MagicHouseInstance
{
    
   
   function MagicHouseInstance()
   {
      super();
   }
}
