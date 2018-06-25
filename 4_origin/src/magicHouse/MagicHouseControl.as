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
      
      public function MagicHouseControl($instance:MagicHouseInstance)
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
      
      private function __showHandler(e:Event) : void
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
      
      private function __hideHandler(e:Event) : void
      {
         if(_magicHouseMainView)
         {
            _magicHouseMainView.close();
         }
      }
      
      private function __freeBoxReturnHandler(e:Event) : void
      {
         var _frame:* = null;
         var aView:AwardsView = new AwardsView();
         aView.goodsList = MagicHouseModel.instance.freeBoxGoodListInfos;
         aView.boxType = 4;
         var title:FilterFrameText = ComponentFactory.Instance.creat("magichouse.collectionView.boxGetAwards");
         title.text = LanguageMgr.GetTranslation("ddt.bagandinfo.awardsTitle");
         title.x = 80;
         _frame = ComponentFactory.Instance.creatComponentByStylename("magichouse.ItemPreviewListFrame");
         var itemName:String = LanguageMgr.GetTranslation("magichouse.collectionView.freeBoxItemName");
         var ai:AlertInfo = new AlertInfo(itemName);
         ai.showCancel = false;
         ai.moveEnable = false;
         _frame.info = ai;
         _frame.addToContent(aView);
         _frame.addToContent(title);
         _frame.addEventListener("response",__frameClose);
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function __chargeBoxReturnHandler(e:Event) : void
      {
         var _frame:* = null;
         var aView:AwardsView = new AwardsView();
         aView.goodsList = MagicHouseModel.instance.chargeBoxGoodListInfos;
         aView.boxType = 4;
         var title:FilterFrameText = ComponentFactory.Instance.creat("magichouse.collectionView.boxGetAwards");
         title.text = LanguageMgr.GetTranslation("ddt.bagandinfo.awardsTitle");
         title.x = 80;
         _frame = ComponentFactory.Instance.creatComponentByStylename("magichouse.ItemPreviewListFrame");
         var itemName:String = LanguageMgr.GetTranslation("magichouse.collectionView.chargeBoxItemName");
         var ai:AlertInfo = new AlertInfo(itemName);
         ai.showCancel = false;
         ai.moveEnable = false;
         _frame.info = ai;
         _frame.addToContent(aView);
         _frame.addToContent(title);
         _frame.addEventListener("response",__frameClose);
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function __frameClose(e:FrameEvent) : void
      {
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         switch(int(e.responseCode) - 2)
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               frame.removeEventListener("response",__frameClose);
               frame.dispose();
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
         var i:int = 0;
         var f:Boolean = false;
         var jarr:* = null;
         var ji:int = 0;
         var arr1:* = null;
         var jm:int = 0;
         var marr:* = null;
         var mi:int = 0;
         var arr2:* = null;
         var mm:int = 0;
         var sarr:* = null;
         var si:int = 0;
         var arr3:* = null;
         var sm:int = 0;
         var bag:BagInfo = PlayerManager.Instance.Self.Bag;
         if(MagicHouseModel.instance.equipOpenList == null)
         {
            MagicHouseModel.instance.equipOpenList = [];
         }
         i = 0;
         while(i < 9)
         {
            f = false;
            if(i < 3)
            {
               jarr = MagicHouseModel.instance.juniorWeaponList[i].split(",");
               for(ji = 0; ji < jarr.length; )
               {
                  arr1 = bag.findItemsByTempleteID(jarr[ji]);
                  for(jm = 0; jm < arr1.length; )
                  {
                     if(arr1[jm] != null && arr1[jm].getRemainDate() > 0)
                     {
                        f = true;
                        break;
                     }
                     jm++;
                  }
                  if(!f)
                  {
                     ji++;
                     continue;
                  }
                  break;
               }
               MagicHouseModel.instance.equipOpenList[i] = f;
            }
            else if(i < 6)
            {
               marr = MagicHouseModel.instance.midWeaponList[i - 3].split(",");
               for(mi = 0; mi < marr.length; )
               {
                  arr2 = bag.findItemsByTempleteID(marr[mi]);
                  for(mm = 0; mm < arr2.length; )
                  {
                     if(arr2[mm] != null && arr2[mm].getRemainDate() > 0)
                     {
                        f = true;
                        break;
                     }
                     mm++;
                  }
                  if(!f)
                  {
                     mi++;
                     continue;
                  }
                  break;
               }
               MagicHouseModel.instance.equipOpenList[i] = f;
            }
            else
            {
               sarr = MagicHouseModel.instance.seniorWeapinList[i - 6].split(",");
               for(si = 0; si < sarr.length; )
               {
                  arr3 = bag.findItemsByTempleteID(sarr[si]);
                  for(sm = 0; sm < arr3.length; )
                  {
                     if(arr3[sm] != null && arr3[sm].getRemainDate() > 0)
                     {
                        f = true;
                        break;
                     }
                     sm++;
                  }
                  if(!f)
                  {
                     si++;
                     continue;
                  }
                  break;
               }
               MagicHouseModel.instance.equipOpenList[i] = f;
            }
            i++;
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
