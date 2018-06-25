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
         var potion:ItemTemplateInfo = ItemManager.Instance.getTemplateById(201489);
         var cellbg:Sprite = new Sprite();
         cellbg.graphics.beginFill(61440,0);
         cellbg.graphics.drawRect(0,0,49,49);
         cellbg.graphics.endFill();
         _potionCell = new BagCell(0,potion,false,cellbg,false);
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
         var j:int = 0;
         var m:int = 0;
         var s:int = 0;
         var finalMagicAttack:int = 0;
         var finalMagicDefense:int = 0;
         var finalCritDamage:int = 0;
         var weapons:Array = MagicHouseModel.instance.activityWeapons;
         var juniorAttribute:Array = MagicHouseModel.instance.juniorAddAttribute;
         var juniorLv:int = MagicHouseModel.instance.magicJuniorLv;
         var minAttribute:Array = MagicHouseModel.instance.midAddAttribute;
         var midLv:int = MagicHouseModel.instance.magicMidLv;
         var seniorAttribute:Array = MagicHouseModel.instance.seniorAddAttribute;
         var seniorLv:int = MagicHouseModel.instance.magicSeniorLv;
         if(weapons[0] && weapons[1] && weapons[2])
         {
            for(j = 0; j <= juniorLv; )
            {
               finalMagicAttack = finalMagicAttack + int(juniorAttribute[j].split(",")[0]);
               finalMagicDefense = finalMagicDefense + int(juniorAttribute[j].split(",")[1]);
               finalCritDamage = finalCritDamage + int(juniorAttribute[j].split(",")[2]);
               j++;
            }
         }
         if(weapons[3] && weapons[4] && weapons[5])
         {
            for(m = 0; m <= midLv; )
            {
               finalMagicAttack = finalMagicAttack + int(minAttribute[m].split(",")[0]);
               finalMagicDefense = finalMagicDefense + int(minAttribute[m].split(",")[1]);
               finalCritDamage = finalCritDamage + int(minAttribute[m].split(",")[2]);
               m++;
            }
         }
         if(weapons[6] && weapons[7] && weapons[8])
         {
            for(s = 0; s <= seniorLv; )
            {
               finalMagicAttack = finalMagicAttack + int(seniorAttribute[s].split(",")[0]);
               finalMagicDefense = finalMagicDefense + int(seniorAttribute[s].split(",")[1]);
               finalCritDamage = finalCritDamage + int(seniorAttribute[s].split(",")[2]);
               s++;
            }
         }
         _valueMagicAttack.text = finalMagicAttack + "%";
         _valueMagicDefense.text = finalMagicDefense + "%";
         _valueCritDamage.text = finalCritDamage + "%";
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
      
      private function __helpClick(e:MouseEvent) : void
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
      
      private function __helpFrameRespose(e:FrameEvent) : void
      {
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            SoundManager.instance.playButtonSound();
            _helpFrame.parent.removeChild(_helpFrame);
         }
      }
      
      private function __closeHelpFrame(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _helpFrame.parent.removeChild(_helpFrame);
      }
      
      private function __messageUpdate(e:Event) : void
      {
         setData();
      }
      
      private function __freeGet(e:MouseEvent) : void
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
      
      private function __chargeGet(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _quick:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("magichouse.collectionView.quickbuypotionframe.titletxt"));
         _quick.itemID = 201489;
         LayerManager.Instance.addToLayer(_quick,2,true,1);
      }
      
      private function __response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:MagicHouseChargeBoxCountFrame = e.currentTarget as MagicHouseChargeBoxCountFrame;
         switch(int(e.responseCode))
         {
            case 0:
            case 1:
               frame.dispose();
               break;
            case 2:
            case 3:
            case 4:
               if(TimeManager.Instance.Now().getDate() != MagicHouseModel.instance.chargeGetTime.getDate())
               {
                  SocketManager.Instance.out.magicLibChargeGet(frame.openCount);
               }
               else if(20 - MagicHouseModel.instance.chargeGetCount >= frame.openCount)
               {
                  SocketManager.Instance.out.magicLibChargeGet(frame.openCount);
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.collectionView.getBoxCountLess"));
               }
               frame.dispose();
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
