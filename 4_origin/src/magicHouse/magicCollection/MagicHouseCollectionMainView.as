package magicHouse.magicCollection
{
   import bagAndInfo.bag.RichesButton;
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import magicHouse.MagicHouseControl;
   import magicHouse.MagicHouseManager;
   import magicHouse.MagicHouseModel;
   
   public class MagicHouseCollectionMainView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _typeWeaponBtn:SimpleBitmapButton;
      
      private var _freeBtn:SimpleBitmapButton;
      
      private var _goldenBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      private var _upgradeBtn:SimpleBitmapButton;
      
      private var _helpFrame:Frame;
      
      private var _bgHelp:Scale9CornerImage;
      
      private var _content:MovieClip;
      
      private var _btnOk:TextButton;
      
      private var _promoteMagicAttack:FilterFrameText;
      
      private var _promoteMagicDefense:FilterFrameText;
      
      private var _promoteCritDamage:FilterFrameText;
      
      private var _valueMagicAttack:FilterFrameText;
      
      private var _valueMagicDefense:FilterFrameText;
      
      private var _valueCritDamage:FilterFrameText;
      
      private var _juniorItem:MagicHouseCollectionItemView;
      
      private var _midItem:MagicHouseCollectionItemView;
      
      private var _seniorItem:MagicHouseCollectionItemView;
      
      private var _freeCell:Bitmap;
      
      private var _freeCellBtn:RichesButton;
      
      private var _freeCountTxt:FilterFrameText;
      
      private var _potionCell:BagCell;
      
      public function MagicHouseCollectionMainView()
      {
         super();
         MagicHouseControl.instance.selectEquipFromBag();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("magichouse.collectionviewbg");
         addChild(_bg);
         _typeWeaponBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.typeWeaponBtn");
         addChild(_typeWeaponBtn);
         _freeBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.freeBtn");
         addChild(_freeBtn);
         _goldenBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.goldenBtn");
         addChild(_goldenBtn);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.helpBtn");
         addChild(_helpBtn);
         _promoteMagicAttack = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.promoteTotleAbilityTxt");
         _promoteMagicDefense = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.promoteTotleAbilityTxt");
         _promoteCritDamage = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.promoteTotleAbilityTxt");
         _promoteMagicAttack.text = LanguageMgr.GetTranslation("magichouse.collectionView.promoteMagicAttack");
         _promoteMagicDefense.text = LanguageMgr.GetTranslation("magichouse.collectionView.promoteMagicDefense");
         _promoteCritDamage.text = LanguageMgr.GetTranslation("magichouse.collectionView.promoteCritDamage");
         PositionUtils.setPos(_promoteMagicAttack,"magicHouse.promoteMagicAttackPos");
         PositionUtils.setPos(_promoteMagicDefense,"magicHouse.promoteMagicDefensePos");
         PositionUtils.setPos(_promoteCritDamage,"magicHouse.promoteCritDamagePos");
         addChild(_promoteMagicAttack);
         addChild(_promoteMagicDefense);
         addChild(_promoteCritDamage);
         _valueMagicAttack = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.valueTotleAbilityTxt");
         _valueMagicDefense = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.valueTotleAbilityTxt");
         _valueCritDamage = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.valueTotleAbilityTxt");
         PositionUtils.setPos(_valueMagicAttack,"magicHouse.valueMagicAttackPos");
         PositionUtils.setPos(_valueMagicDefense,"magicHouse.valueMagicDefensePos");
         PositionUtils.setPos(_valueCritDamage,"magicHouse.valueCritDamagePos");
         addChild(_valueMagicAttack);
         addChild(_valueMagicDefense);
         addChild(_valueCritDamage);
         _juniorItem = new MagicHouseCollectionItemView(1);
         _midItem = new MagicHouseCollectionItemView(2);
         _seniorItem = new MagicHouseCollectionItemView(3);
         addChild(_juniorItem);
         addChild(_midItem);
         addChild(_seniorItem);
         PositionUtils.setPos(_midItem,"magicHouse.collection.miditemPos");
         PositionUtils.setPos(_seniorItem,"magicHouse.collection.senioritemPos");
         _freeCell = ComponentFactory.Instance.creatBitmap("magichouse.collection.freeCell");
         addChild(_freeCell);
         _freeCellBtn = ComponentFactory.Instance.creatCustomObject("magichouse.collectionView.freeBtn");
         _freeCellBtn.tipData = LanguageMgr.GetTranslation("magichouse.collectionView.freeGetTips");
         addChild(_freeCellBtn);
         _freeCountTxt = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionMainView.freeCountTxt");
         _freeCountTxt.text = "(" + (5 - MagicHouseModel.instance.freeGetCount) + ")";
         addChild(_freeCountTxt);
         var _loc2_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(201489);
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(61440,0);
         _loc1_.graphics.drawRect(0,0,49,49);
         _loc1_.graphics.endFill();
         _potionCell = new BagCell(0,_loc2_,false,_loc1_,false);
         var _loc3_:int = 47;
         _potionCell.height = _loc3_;
         _potionCell.width = _loc3_;
         addChild(_potionCell);
         PositionUtils.setPos(_potionCell,"magichouse.collectionview.potioncell.pos");
         if(MagicHouseControl.instance.checkGetFreeBoxTime())
         {
            _freeCountTxt.text = "(5)";
         }
         setData();
      }
      
      private function setData() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         var _loc13_:int = 0;
         var _loc12_:Array = MagicHouseModel.instance.activityWeapons;
         var _loc2_:Array = MagicHouseModel.instance.juniorAddAttribute;
         var _loc6_:int = MagicHouseModel.instance.magicJuniorLv;
         var _loc7_:Array = MagicHouseModel.instance.midAddAttribute;
         var _loc10_:int = MagicHouseModel.instance.magicMidLv;
         var _loc3_:Array = MagicHouseModel.instance.seniorAddAttribute;
         var _loc11_:int = MagicHouseModel.instance.magicSeniorLv;
         if(_loc12_[0] && _loc12_[1] && _loc12_[2])
         {
            _loc5_ = 0;
            while(_loc5_ <= _loc6_)
            {
               _loc9_ = _loc9_ + int(_loc2_[_loc5_].split(",")[0]);
               _loc1_ = _loc1_ + int(_loc2_[_loc5_].split(",")[1]);
               _loc13_ = _loc13_ + int(_loc2_[_loc5_].split(",")[2]);
               _loc5_++;
            }
         }
         if(_loc12_[3] && _loc12_[4] && _loc12_[5])
         {
            _loc4_ = 0;
            while(_loc4_ <= _loc10_)
            {
               _loc9_ = _loc9_ + int(_loc7_[_loc4_].split(",")[0]);
               _loc1_ = _loc1_ + int(_loc7_[_loc4_].split(",")[1]);
               _loc13_ = _loc13_ + int(_loc7_[_loc4_].split(",")[2]);
               _loc4_++;
            }
         }
         if(_loc12_[6] && _loc12_[7] && _loc12_[8])
         {
            _loc8_ = 0;
            while(_loc8_ <= _loc11_)
            {
               _loc9_ = _loc9_ + int(_loc3_[_loc8_].split(",")[0]);
               _loc1_ = _loc1_ + int(_loc3_[_loc8_].split(",")[1]);
               _loc13_ = _loc13_ + int(_loc3_[_loc8_].split(",")[2]);
               _loc8_++;
            }
         }
         _valueMagicAttack.text = _loc9_ + "%";
         _valueMagicDefense.text = _loc1_ + "%";
         _valueCritDamage.text = _loc13_ + "%";
         _freeCountTxt.text = "(" + (5 - MagicHouseModel.instance.freeGetCount) + ")";
         if(MagicHouseControl.instance.checkGetFreeBoxTime())
         {
            _freeCountTxt.text = "(5)";
         }
      }
      
      private function initEvent() : void
      {
         _freeBtn.addEventListener("click",__freeGet);
         _goldenBtn.addEventListener("click",__chargeGet);
         _helpBtn.addEventListener("click",__helpClick);
         MagicHouseManager.instance.addEventListener("magichouse_updata",__messageUpdate);
      }
      
      private function removeEvent() : void
      {
         _freeBtn.removeEventListener("click",__freeGet);
         _goldenBtn.removeEventListener("click",__chargeGet);
         _helpBtn.removeEventListener("click",__helpClick);
         MagicHouseManager.instance.removeEventListener("magichouse_updata",__messageUpdate);
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(!_helpFrame)
         {
            _helpFrame = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.main");
            _helpFrame.titleText = LanguageMgr.GetTranslation("magichouse.mainview.frametitletext");
            _helpFrame.addEventListener("response",__helpFrameRespose);
            _bgHelp = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.bgHelp");
            _content = ComponentFactory.Instance.creatCustomObject("magichouse.collection.help.content");
            _btnOk = ComponentFactory.Instance.creatComponentByStylename("cardSystem.help.btnOk");
            _btnOk.text = LanguageMgr.GetTranslation("ok");
            _btnOk.addEventListener("click",__closeHelpFrame);
            _helpFrame.addToContent(_bgHelp);
            _helpFrame.addToContent(_content);
            _helpFrame.addToContent(_btnOk);
         }
         LayerManager.Instance.addToLayer(_helpFrame,3,true,2);
      }
      
      private function __helpFrameRespose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      private function __closeHelpFrame(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _helpFrame.parent.removeChild(_helpFrame);
      }
      
      private function __messageUpdate(param1:Event) : void
      {
         setData();
      }
      
      private function __freeGet(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(TimeManager.Instance.Now().getDate() != MagicHouseModel.instance.freeGetTime.getDate())
         {
            SocketManager.Instance.out.magicLibFreeGet(5);
         }
         else if(5 - MagicHouseModel.instance.freeGetCount > 0)
         {
            SocketManager.Instance.out.magicLibFreeGet(5);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.collectionView.getBoxCountLess"));
         }
      }
      
      private function __chargeGet(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _loc2_.setTitleText(LanguageMgr.GetTranslation("magichouse.collectionView.quickbuypotionframe.titletxt"));
         _loc2_.itemID = 201489;
         LayerManager.Instance.addToLayer(_loc2_,2,true,1);
      }
      
      private function __response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:MagicHouseChargeBoxCountFrame = param1.currentTarget as MagicHouseChargeBoxCountFrame;
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _loc2_.dispose();
               break;
            case 2:
            case 3:
            case 4:
               if(TimeManager.Instance.Now().getDate() != MagicHouseModel.instance.chargeGetTime.getDate())
               {
                  SocketManager.Instance.out.magicLibChargeGet(_loc2_.openCount);
               }
               else if(20 - MagicHouseModel.instance.chargeGetCount >= _loc2_.openCount)
               {
                  SocketManager.Instance.out.magicLibChargeGet(_loc2_.openCount);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.collectionView.getBoxCountLess"));
               }
               _loc2_.dispose();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_typeWeaponBtn)
         {
            _typeWeaponBtn.dispose();
         }
         _typeWeaponBtn = null;
         if(_freeBtn)
         {
            _freeBtn.dispose();
         }
         _freeBtn = null;
         if(_goldenBtn)
         {
            _goldenBtn.dispose();
         }
         _goldenBtn = null;
         if(_helpBtn)
         {
            _helpBtn.dispose();
         }
         _helpBtn = null;
         if(_upgradeBtn)
         {
            _upgradeBtn.dispose();
         }
         _upgradeBtn = null;
         if(_helpFrame)
         {
            _helpFrame.dispose();
         }
         _helpFrame = null;
         if(_bgHelp)
         {
            _bgHelp.dispose();
         }
         _bgHelp = null;
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
         }
         _content = null;
         if(_btnOk)
         {
            _btnOk.dispose();
         }
         _btnOk = null;
         if(_promoteMagicAttack)
         {
            _promoteMagicAttack.dispose();
         }
         _promoteMagicAttack = null;
         if(_promoteMagicDefense)
         {
            _promoteMagicDefense.dispose();
         }
         _promoteMagicDefense = null;
         if(_promoteCritDamage)
         {
            _promoteCritDamage.dispose();
         }
         _promoteCritDamage = null;
         if(_valueMagicAttack)
         {
            _valueMagicAttack.dispose();
         }
         _valueMagicAttack = null;
         if(_valueMagicDefense)
         {
            _valueMagicDefense.dispose();
         }
         _valueMagicDefense = null;
         if(_valueCritDamage)
         {
            _valueCritDamage.dispose();
         }
         _valueCritDamage = null;
         if(_freeCell)
         {
            ObjectUtils.disposeObject(_freeCell);
         }
         _freeCell = null;
         if(_freeCellBtn)
         {
            ObjectUtils.disposeObject(_freeCellBtn);
         }
         _freeCellBtn = null;
         if(_freeCountTxt)
         {
            ObjectUtils.disposeObject(_freeCountTxt);
         }
         _freeCountTxt = null;
         if(_juniorItem)
         {
            _juniorItem.dispose();
         }
         _juniorItem = null;
         if(_midItem)
         {
            _midItem.dispose();
         }
         _midItem = null;
         if(_seniorItem)
         {
            _seniorItem.dispose();
         }
         _seniorItem = null;
         if(_potionCell)
         {
            ObjectUtils.disposeObject(_potionCell);
         }
         _potionCell = null;
      }
   }
}
