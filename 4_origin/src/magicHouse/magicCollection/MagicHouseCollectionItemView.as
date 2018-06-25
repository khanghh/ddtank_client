package magicHouse.magicCollection
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.tips.CallPropTxtTipInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import magicHouse.MagicHouseManager;
   import magicHouse.MagicHouseModel;
   import newTitle.NewTitleManager;
   
   public class MagicHouseCollectionItemView extends Sprite implements Disposeable
   {
       
      
      private var _self:SelfInfo;
      
      private var _item1:MagicHouseItemCell;
      
      private var _item2:MagicHouseItemCell;
      
      private var _item3:MagicHouseItemCell;
      
      private var _type:int;
      
      private var _addAttributeTxt:FilterFrameText;
      
      private var _attribute1:FilterFrameText;
      
      private var _attribute2:FilterFrameText;
      
      private var _attributeValue1:FilterFrameText;
      
      private var _attributeValue2:FilterFrameText;
      
      private var _nextLevelPromote:FilterFrameText;
      
      private var _nextAttribute1:FilterFrameText;
      
      private var _nextAttribute2:FilterFrameText;
      
      private var _nextValue1:FilterFrameText;
      
      private var _nextValue2:FilterFrameText;
      
      private var _itemLvl:FilterFrameText;
      
      private var _upGradeCell:BagCell;
      
      private var _progress:MagicHouseUpgradeProgress;
      
      private var _collectionType:Bitmap;
      
      private var _collectionTypeCon:Component;
      
      private var _upGradeBtn:SimpleBitmapButton;
      
      private var _potionCountSelecterFrame:MagicHouseMagicPotionSelectFrame;
      
      private var _lastStrengthTime:int = 0;
      
      public function MagicHouseCollectionItemView(type:int)
      {
         super();
         _type = type;
         _self = PlayerManager.Instance.Self;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var titleID:int = 0;
         var titleInfo:* = null;
         _item1 = new MagicHouseItemCell();
         addChild(_item1);
         PositionUtils.setPos(_item1,"magicHouse.collection.itemcell1Pos");
         _item2 = new MagicHouseItemCell();
         addChild(_item2);
         PositionUtils.setPos(_item2,"magicHouse.collection.itemcell2Pos");
         _item3 = new MagicHouseItemCell();
         addChild(_item3);
         PositionUtils.setPos(_item3,"magicHouse.collection.itemcell3Pos");
         _addAttributeTxt = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.filterText1");
         addChild(_addAttributeTxt);
         _addAttributeTxt.text = LanguageMgr.GetTranslation("magichouse.collectionItem.addAttribute" + _type);
         PositionUtils.setPos(_addAttributeTxt,"magicHouse.collection.itemAddAttributeTxtPos");
         _attribute1 = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.filterText2");
         addChild(_attribute1);
         PositionUtils.setPos(_attribute1,"magicHouse.collection.itemAttributeTxtPos1");
         _attribute2 = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.filterText2");
         addChild(_attribute2);
         PositionUtils.setPos(_attribute2,"magicHouse.collection.itemAttributeTxtPos2");
         _attributeValue1 = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.filterText3");
         addChild(_attributeValue1);
         PositionUtils.setPos(_attributeValue1,"magicHouse.collection.itemAttributeValueTxtPos1");
         _attributeValue2 = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.filterText3");
         addChild(_attributeValue2);
         PositionUtils.setPos(_attributeValue2,"magicHouse.collection.itemAttributeValueTxtPos2");
         _nextLevelPromote = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.filterText1");
         addChild(_nextLevelPromote);
         PositionUtils.setPos(_nextLevelPromote,"magicHouse.collection.itemNextLevelTxtPos");
         _nextLevelPromote.text = LanguageMgr.GetTranslation("magichouse.collectionItem.nextLevelPromote");
         _nextAttribute1 = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.filterText2");
         addChild(_nextAttribute1);
         PositionUtils.setPos(_nextAttribute1,"magicHouse.collection.itemNextLevelAttributeTxtPos1");
         _nextAttribute2 = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.filterText2");
         addChild(_nextAttribute2);
         PositionUtils.setPos(_nextAttribute2,"magicHouse.collection.itemNextLevelAttributeTxtPos2");
         _nextValue1 = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.filterText3");
         addChild(_nextValue1);
         PositionUtils.setPos(_nextValue1,"magicHouse.collection.itemNextLevelValueTxtPos1");
         _nextValue2 = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.filterText3");
         addChild(_nextValue2);
         PositionUtils.setPos(_nextValue2,"magicHouse.collection.itemNextLevelValueTxtPos2");
         _itemLvl = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.itemLvlText");
         addChild(_itemLvl);
         var info:ItemTemplateInfo = ItemManager.Instance.getTemplateById(201489);
         _upGradeCell = new BagCell(0,info,true,ComponentFactory.Instance.creatBitmap("magichouse.collectionItem.potionCellBg"));
         _upGradeCell.PicPos = new Point(2,2);
         addChild(_upGradeCell);
         var _loc4_:int = 52;
         _upGradeCell.height = _loc4_;
         _upGradeCell.width = _loc4_;
         PositionUtils.setPos(_upGradeCell,"magicHouse.collection.itemUpGradeCellPos");
         _progress = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItem.upgrade.progress");
         _progress.tipStyle = "ddt.view.tips.OneLineTip";
         _progress.tipDirctions = "3,7,6";
         _progress.tipGapV = 4;
         addChild(_progress);
         _collectionType = ComponentFactory.Instance.creatBitmap("magichouse.collection.item" + _type);
         _collectionTypeCon = ComponentFactory.Instance.creatComponentByStylename("magichouse.collectionItem.titleTipContent");
         if(_type == 1)
         {
            titleID = 1010;
         }
         else if(_type == 2)
         {
            titleID = 1011;
         }
         else
         {
            titleID = 1012;
         }
         if(NewTitleManager.instance.titleInfo && NewTitleManager.instance.titleInfo[titleID])
         {
            titleInfo = new CallPropTxtTipInfo();
            titleInfo.Attack = NewTitleManager.instance.titleInfo[titleID].Att;
            titleInfo.Defend = NewTitleManager.instance.titleInfo[titleID].Def;
            titleInfo.Agility = NewTitleManager.instance.titleInfo[titleID].Agi;
            titleInfo.Lucky = NewTitleManager.instance.titleInfo[titleID].Luck;
            _collectionTypeCon.tipData = titleInfo;
         }
         _collectionTypeCon.addChild(_collectionType);
         addChild(_collectionTypeCon);
         _upGradeBtn = ComponentFactory.Instance.creatComponentByStylename("magicHouse.collectionItemView.UpGradeBtn");
         addChild(_upGradeBtn);
         _setData();
         _initProgress();
      }
      
      private function _initProgress() : void
      {
         if(_type == 1)
         {
            _progress.initProgress(MagicHouseModel.instance.magicJuniorLv,MagicHouseModel.instance.magicJuniorExp);
         }
         else if(_type == 2)
         {
            _progress.initProgress(MagicHouseModel.instance.magicMidLv,MagicHouseModel.instance.magicMidExp);
         }
         else
         {
            _progress.initProgress(MagicHouseModel.instance.magicSeniorLv,MagicHouseModel.instance.magicSeniorExp);
         }
      }
      
      private function _updateProgress() : void
      {
         if(_type == 1)
         {
            _progress.setProgress(MagicHouseModel.instance.magicJuniorLv,MagicHouseModel.instance.magicJuniorExp);
         }
         else if(_type == 2)
         {
            _progress.setProgress(MagicHouseModel.instance.magicMidLv,MagicHouseModel.instance.magicMidExp);
         }
         else
         {
            _progress.setProgress(MagicHouseModel.instance.magicSeniorLv,MagicHouseModel.instance.magicSeniorExp);
         }
      }
      
      private function _setCell() : void
      {
         if(_type == 1)
         {
            _item1.setTypeAndPos(_type,0);
            if(MagicHouseModel.instance.activityWeapons[0] != 0)
            {
               _item1.setOpened(true);
            }
            _item1.cellInfo = ItemManager.Instance.getTemplateById(MagicHouseModel.instance.juniorWeaponList[0].split(",")[0]);
            if(MagicHouseModel.instance.activityWeapons[0] == 0)
            {
               _item1.setFilter();
            }
            _item2.setTypeAndPos(_type,1);
            if(MagicHouseModel.instance.activityWeapons[1] != 0)
            {
               _item2.setOpened(true);
            }
            _item2.cellInfo = ItemManager.Instance.getTemplateById(MagicHouseModel.instance.juniorWeaponList[1].split(",")[0]);
            if(MagicHouseModel.instance.activityWeapons[1] == 0)
            {
               _item2.setFilter();
            }
            _item3.setTypeAndPos(_type,2);
            if(MagicHouseModel.instance.activityWeapons[2] != 0)
            {
               _item3.setOpened(true);
            }
            _item3.cellInfo = ItemManager.Instance.getTemplateById(MagicHouseModel.instance.juniorWeaponList[2].split(",")[0]);
            if(MagicHouseModel.instance.activityWeapons[2] == 0)
            {
               _item3.setFilter();
            }
         }
         else if(_type == 2)
         {
            _item1.setTypeAndPos(_type,0);
            if(MagicHouseModel.instance.activityWeapons[3] != 0)
            {
               _item1.setOpened(true);
            }
            _item1.cellInfo = ItemManager.Instance.getTemplateById(MagicHouseModel.instance.midWeaponList[0].split(",")[0]);
            if(MagicHouseModel.instance.activityWeapons[3] == 0)
            {
               _item1.setFilter();
            }
            _item2.setTypeAndPos(_type,1);
            if(MagicHouseModel.instance.activityWeapons[4] != 0)
            {
               _item2.setOpened(true);
            }
            _item2.cellInfo = ItemManager.Instance.getTemplateById(MagicHouseModel.instance.midWeaponList[1].split(",")[0]);
            if(MagicHouseModel.instance.activityWeapons[4] == 0)
            {
               _item2.setFilter();
            }
            _item3.setTypeAndPos(_type,2);
            if(MagicHouseModel.instance.activityWeapons[5] != 0)
            {
               _item3.setOpened(true);
            }
            _item3.cellInfo = ItemManager.Instance.getTemplateById(MagicHouseModel.instance.midWeaponList[2].split(",")[0]);
            if(MagicHouseModel.instance.activityWeapons[5] == 0)
            {
               _item3.setFilter();
            }
         }
         else
         {
            _item1.setTypeAndPos(_type,0);
            if(MagicHouseModel.instance.activityWeapons[6] != 0)
            {
               _item1.setOpened(true);
            }
            _item1.cellInfo = ItemManager.Instance.getTemplateById(MagicHouseModel.instance.seniorWeapinList[0].split(",")[0]);
            if(MagicHouseModel.instance.activityWeapons[6] == 0)
            {
               _item1.setFilter();
            }
            _item2.setTypeAndPos(_type,1);
            if(MagicHouseModel.instance.activityWeapons[7] != 0)
            {
               _item2.setOpened(true);
            }
            _item2.cellInfo = ItemManager.Instance.getTemplateById(MagicHouseModel.instance.seniorWeapinList[1].split(",")[0]);
            if(MagicHouseModel.instance.activityWeapons[7] == 0)
            {
               _item2.setFilter();
            }
            _item3.setTypeAndPos(_type,2);
            if(MagicHouseModel.instance.activityWeapons[8] != 0)
            {
               _item3.setOpened(true);
            }
            _item3.cellInfo = ItemManager.Instance.getTemplateById(MagicHouseModel.instance.seniorWeapinList[2].split(",")[0]);
            if(MagicHouseModel.instance.activityWeapons[8] == 0)
            {
               _item3.setFilter();
            }
         }
      }
      
      private function _setData() : void
      {
         var itemLvl:int = 0;
         var j:int = 0;
         var m:int = 0;
         var s:int = 0;
         _setCell();
         upDatafitCount();
         var weapons:Array = MagicHouseModel.instance.activityWeapons;
         var juniorAttribute:Array = MagicHouseModel.instance.juniorAddAttribute;
         var juniorLv:int = MagicHouseModel.instance.magicJuniorLv;
         var minAttribute:Array = MagicHouseModel.instance.midAddAttribute;
         var midLv:int = MagicHouseModel.instance.magicMidLv;
         var seniorAttribute:Array = MagicHouseModel.instance.seniorAddAttribute;
         var seniorLv:int = MagicHouseModel.instance.magicSeniorLv;
         var attribute1:int = 0;
         var attribute2:int = 0;
         if(_type == 1)
         {
            var _loc14_:* = LanguageMgr.GetTranslation("magichouse.collectionItem.addMagicDamage");
            _nextAttribute1.text = _loc14_;
            _attribute1.text = _loc14_;
            _loc14_ = LanguageMgr.GetTranslation("magichouse.collectionItem.addMagicDefense");
            _nextAttribute2.text = _loc14_;
            _attribute2.text = _loc14_;
            itemLvl = MagicHouseModel.instance.magicJuniorLv;
            _itemLvl.text = "Lv." + itemLvl;
            if(weapons[0] != 0 && weapons[1] != 0 && weapons[2] != 0)
            {
               _addAttributeTxt.text = LanguageMgr.GetTranslation("magichouse.collectionItem.addAttribute" + _type);
               for(j = 0; j <= juniorLv; )
               {
                  attribute1 = attribute1 + int(juniorAttribute[j].split(",")[0]);
                  attribute2 = attribute2 + int(juniorAttribute[j].split(",")[1]);
                  j++;
               }
               if(juniorLv == juniorAttribute.length - 1)
               {
                  _nextValue1.text = LanguageMgr.GetTranslation("magichouse.collectionItem.maxLevel");
                  PositionUtils.setPos(_nextValue1,"magicHouse.attributeTopTxtPos");
                  _nextLevelPromote.visible = false;
                  _nextAttribute1.visible = false;
                  _nextAttribute2.visible = false;
                  _nextValue2.visible = false;
               }
               else
               {
                  _nextValue1.text = juniorAttribute[juniorLv + 1].split(",")[0] + "%";
                  _nextValue2.text = juniorAttribute[juniorLv + 1].split(",")[1] + "%";
               }
            }
            else
            {
               _addAttributeTxt.text = LanguageMgr.GetTranslation("magichouse.collectionItem.afterActivate");
               attribute1 = juniorAttribute[0].split(",")[0];
               attribute2 = juniorAttribute[0].split(",")[1];
               _nextValue1.text = juniorAttribute[1].split(",")[0] + "%";
               _nextValue2.text = juniorAttribute[1].split(",")[1] + "%";
            }
         }
         else if(_type == 2)
         {
            _addAttributeTxt.text = LanguageMgr.GetTranslation("magichouse.collectionItem.addAttribute" + _type);
            _loc14_ = LanguageMgr.GetTranslation("magichouse.collectionItem.addMagicDefense");
            _nextAttribute1.text = _loc14_;
            _attribute1.text = _loc14_;
            _loc14_ = LanguageMgr.GetTranslation("magichouse.collectionItem.addCritDamage");
            _nextAttribute2.text = _loc14_;
            _attribute2.text = _loc14_;
            itemLvl = MagicHouseModel.instance.magicMidLv;
            _itemLvl.text = "Lv." + itemLvl;
            if(weapons[3] != 0 && weapons[4] != 0 && weapons[5] != 0)
            {
               for(m = 0; m <= midLv; )
               {
                  attribute1 = attribute1 + int(minAttribute[m].split(",")[1]);
                  attribute2 = attribute2 + int(minAttribute[m].split(",")[2]);
                  m++;
               }
               if(midLv == minAttribute.length - 1)
               {
                  _nextValue1.text = LanguageMgr.GetTranslation("magichouse.collectionItem.maxLevel");
                  PositionUtils.setPos(_nextValue1,"magicHouse.attributeTopTxtPos");
                  _nextLevelPromote.visible = false;
                  _nextAttribute1.visible = false;
                  _nextAttribute2.visible = false;
                  _nextValue2.visible = false;
               }
               else
               {
                  _nextValue1.text = minAttribute[midLv + 1].split(",")[1] + "%";
                  _nextValue2.text = minAttribute[midLv + 1].split(",")[2] + "%";
               }
            }
            else
            {
               _addAttributeTxt.text = LanguageMgr.GetTranslation("magichouse.collectionItem.afterActivate");
               attribute1 = minAttribute[0].split(",")[1];
               attribute2 = minAttribute[0].split(",")[2];
               _nextValue1.text = minAttribute[1].split(",")[1] + "%";
               _nextValue2.text = minAttribute[1].split(",")[2] + "%";
            }
         }
         else
         {
            _addAttributeTxt.text = LanguageMgr.GetTranslation("magichouse.collectionItem.addAttribute" + _type);
            _loc14_ = LanguageMgr.GetTranslation("magichouse.collectionItem.addMagicDamage");
            _nextAttribute1.text = _loc14_;
            _attribute1.text = _loc14_;
            _loc14_ = LanguageMgr.GetTranslation("magichouse.collectionItem.addCritDamage");
            _nextAttribute2.text = _loc14_;
            _attribute2.text = _loc14_;
            itemLvl = MagicHouseModel.instance.magicSeniorLv;
            _itemLvl.text = "Lv." + itemLvl;
            if(weapons[6] != 0 && weapons[7] != 0 && weapons[8] != 0)
            {
               for(s = 0; s <= seniorLv; )
               {
                  attribute1 = attribute1 + int(seniorAttribute[s].split(",")[0]);
                  attribute2 = attribute2 + int(seniorAttribute[s].split(",")[2]);
                  s++;
               }
               if(seniorLv == seniorAttribute.length - 1)
               {
                  _nextValue1.text = LanguageMgr.GetTranslation("magichouse.collectionItem.maxLevel");
                  PositionUtils.setPos(_nextValue1,"magicHouse.attributeTopTxtPos");
                  _nextLevelPromote.visible = false;
                  _nextAttribute1.visible = false;
                  _nextAttribute2.visible = false;
                  _nextValue2.visible = false;
               }
               else
               {
                  _nextValue1.text = seniorAttribute[seniorLv + 1].split(",")[0] + "%";
                  _nextValue2.text = seniorAttribute[seniorLv + 1].split(",")[2] + "%";
               }
            }
            else
            {
               _addAttributeTxt.text = LanguageMgr.GetTranslation("magichouse.collectionItem.afterActivate");
               attribute1 = seniorAttribute[0].split(",")[0];
               attribute2 = seniorAttribute[0].split(",")[2];
               _nextValue1.text = seniorAttribute[1].split(",")[0] + "%";
               _nextValue2.text = seniorAttribute[1].split(",")[2] + "%";
            }
         }
         _attributeValue1.text = attribute1 + "%";
         _attributeValue2.text = attribute2 + "%";
         _upGradeBtn.enable = _item1.isOpen && _item2.isOpen && _item3.isOpen && itemLvl < 5;
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener("buygoods",onBuyedGoods);
         _upGradeBtn.addEventListener("click",__upGrade);
         MagicHouseManager.instance.addEventListener("magichouse_updata",__messageUpdate);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener("buygoods",onBuyedGoods);
         _upGradeBtn.removeEventListener("click",__upGrade);
         MagicHouseManager.instance.removeEventListener("magichouse_updata",__messageUpdate);
      }
      
      private function onBuyedGoods(event:CrazyTankSocketEvent) : void
      {
         upDatafitCount();
      }
      
      private function __upGrade(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201489) > 0)
         {
            _potionCountSelecterFrame = ComponentFactory.Instance.creatComponentByStylename("magichouse.magicpotion.selecterFrame");
            _potionCountSelecterFrame.type = _type;
            LayerManager.Instance.addToLayer(_potionCountSelecterFrame,3,true,1);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("magichouse.collectionItem.magicPotionLess"));
         }
      }
      
      private function __messageUpdate(e:Event) : void
      {
         _setData();
         _updateProgress();
      }
      
      public function upDatafitCount() : void
      {
         if(!_upGradeCell)
         {
            return;
         }
         var bagInfo:BagInfo = _self.getBag(1);
         var conut:int = bagInfo.getItemCountByTemplateId(201489);
         _upGradeCell.setCount(conut);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_item1)
         {
            _item1.dispose();
         }
         _item1 = null;
         if(_item2)
         {
            _item2.dispose();
         }
         _item2 = null;
         if(_item3)
         {
            _item3.dispose();
         }
         _item3 = null;
         if(_addAttributeTxt)
         {
            _addAttributeTxt.dispose();
         }
         _addAttributeTxt = null;
         if(_attribute1)
         {
            _attribute1.dispose();
         }
         _attribute1 = null;
         if(_attribute2)
         {
            _attribute2.dispose();
         }
         _attribute2 = null;
         if(_attributeValue1)
         {
            _attributeValue1.dispose();
         }
         _attributeValue1 = null;
         if(_attributeValue2)
         {
            _attributeValue2.dispose();
         }
         _attributeValue2 = null;
         if(_nextLevelPromote)
         {
            _nextLevelPromote.dispose();
         }
         _nextLevelPromote = null;
         if(_nextAttribute1)
         {
            _nextAttribute1.dispose();
         }
         _nextAttribute1 = null;
         if(_nextAttribute2)
         {
            _nextAttribute2.dispose();
         }
         _nextAttribute2 = null;
         if(_nextValue1)
         {
            _nextValue1.dispose();
         }
         _nextValue1 = null;
         if(_nextValue2)
         {
            _nextValue2.dispose();
         }
         _nextValue2 = null;
         if(_itemLvl)
         {
            _itemLvl.dispose();
         }
         _itemLvl = null;
         if(_upGradeCell)
         {
            _upGradeCell.dispose();
         }
         _upGradeCell = null;
         if(_progress)
         {
            _progress.dispose();
         }
         _progress = null;
         if(_collectionType)
         {
            ObjectUtils.disposeObject(_collectionType);
         }
         _collectionType = null;
         if(_collectionTypeCon)
         {
            ObjectUtils.disposeObject(_collectionTypeCon);
         }
         _collectionTypeCon = null;
         if(_upGradeBtn)
         {
            _upGradeBtn.dispose();
         }
         _upGradeBtn = null;
      }
   }
}
