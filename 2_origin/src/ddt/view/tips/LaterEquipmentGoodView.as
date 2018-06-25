package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.EquipSuitTemplateInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.QualityType;
   import ddt.data.goods.SuitTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   
   public class LaterEquipmentGoodView extends Component
   {
      
      public static const THISWIDTH:int = 200;
      
      public static const EQUIPNUM:int = 19;
      
      public static var isShow:Boolean = true;
       
      
      private var SUITNUM:int;
      
      private var _bg:ScaleBitmapImage;
      
      private var _topName:FilterFrameText;
      
      private var _setNum:FilterFrameText;
      
      private var _rule1:ScaleBitmapImage;
      
      private var _rule2:ScaleBitmapImage;
      
      private var _setsPropVec:Vector.<FilterFrameText>;
      
      private var _validity:Vector.<FilterFrameText>;
      
      private var _thisHeight:int;
      
      private var _thisWidht:int;
      
      private var _info:SuitTemplateInfo;
      
      private var _itemInfo:ItemTemplateInfo;
      
      private var _EquipInfo:InventoryItemInfo;
      
      private var _playerInfo:PlayerInfo;
      
      private var _suitId:int;
      
      private var _ContainEquip:Array;
      
      public function LaterEquipmentGoodView()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      private function initData() : void
      {
         var arr:* = null;
         var i:int = 0;
         if(ItemManager.Instance.EquipSuit)
         {
            arr = ItemManager.Instance.EquipSuit[_info.SuitId] as Array;
            if(arr)
            {
               SUITNUM = arr.length;
            }
         }
         _setsPropVec = new Vector.<FilterFrameText>(SUITNUM);
         _validity = new Vector.<FilterFrameText>(SUITNUM);
         for(i = 0; i < SUITNUM; )
         {
            _setsPropVec[i] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.setsPropText");
            _validity[i] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.setsPropText");
            i++;
         }
      }
      
      private function showText() : void
      {
         var j:int = 0;
         for(j = 0; j < SUITNUM; )
         {
            addChild(_setsPropVec[j]);
            addChild(_validity[j]);
            j++;
         }
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(data:Object) : void
      {
         if(data)
         {
            _itemInfo = data as ItemTemplateInfo;
            this.visible = true;
            _tipData = _itemInfo;
            _suitId = _itemInfo.SuitId;
            if(_suitId != 0)
            {
               _info = ItemManager.Instance.getSuitTemplateByID(String(_suitId));
               if(_info)
               {
                  showTip();
               }
               else
               {
                  this.visible = false;
               }
            }
            else
            {
               this.visible = false;
            }
         }
         else
         {
            this.visible = false;
         }
      }
      
      public function showTip() : void
      {
         updateView();
      }
      
      private function updateView() : void
      {
         clear();
         initData();
         showText();
         showHeadPart();
         showMiddlePart();
         showButtomPart();
         upBackground();
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         _rule1 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _rule2 = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _topName = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.name");
         _setNum = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.name");
         addChild(_bg);
         addChild(_rule1);
         addChild(_rule2);
         addChild(_topName);
         addChild(_setNum);
      }
      
      private function showHeadPart() : void
      {
         _topName.text = _info.SuitName;
         if(!LaterEquipmentGoodView.isShow)
         {
            _topName.textColor = 10066329;
         }
         _rule1.x = _topName.x;
         _rule1.y = _topName.y + _topName.textHeight + 10;
         _thisHeight = _rule1.y + _rule1.height;
         _thisWidht = _thisWidht > _rule1.y + _rule1.width?_thisWidht:_rule1.y + _rule1.width;
      }
      
      private function showMiddlePart() : void
      {
         var j:int = 0;
         var equipInfo:* = null;
         var k:int = 0;
         var i:int = 0;
         var equipinfo:* = null;
         var equip:* = null;
         var n:int = 0;
         var index:int = 0;
         _playerInfo = !!ItemManager.Instance.playerInfo?ItemManager.Instance.playerInfo:PlayerManager.Instance.Self;
         _ContainEquip = ItemManager.Instance.EquipSuit[_info.SuitId] as Array;
         if(_ContainEquip == null)
         {
            return;
         }
         var propArr:Array = [];
         var containequip:Array = [];
         var equipArr:Array = [];
         var signArr:Array = [];
         for(j = 0; j < _ContainEquip.length; )
         {
            if(_ContainEquip[j])
            {
               equipInfo = ItemManager.Instance.getTemplateById(int(_ContainEquip[j]));
               propArr.push(_ContainEquip[j].PartName);
            }
            j++;
         }
         for(k = 0; k < 19; )
         {
            _EquipInfo = _playerInfo.Bag.getItemAt(k);
            if(_EquipInfo != null)
            {
               equipArr.push([_EquipInfo.TemplateID,_EquipInfo.Place]);
            }
            k++;
         }
         for(i = 0; i < _setsPropVec.length; )
         {
            if(i < propArr.length)
            {
               _setsPropVec[i].visible = true;
               _setsPropVec[i].text = propArr[i];
               equipinfo = ItemManager.Instance.getEquipSuitbyContainEquip(_setsPropVec[i].text);
               equip = equipinfo.ContainEquip.split(",");
               loop3:
               for(n = 0; n < equipArr.length; )
               {
                  for(index = 0; index < equip.length; )
                  {
                     if(equip[index] == equipArr[n][0] && signArr.indexOf(equipArr[n]) == -1)
                     {
                        _setsPropVec[i].textColor = 10092339;
                        signArr.push(equipArr[n]);
                        break loop3;
                     }
                     _setsPropVec[i].textColor = 10066329;
                     index++;
                  }
                  n++;
               }
               if(!LaterEquipmentGoodView.isShow)
               {
                  _setsPropVec[i].textColor = 10066329;
               }
               if(!LaterEquipmentGoodView.isShow)
               {
                  _setsPropVec[i].textColor = 10066329;
               }
               _setsPropVec[i].y = _rule1.y + _rule1.height + 8 + 24 * i;
               if(i == propArr.length - 1)
               {
                  _rule2.x = _setsPropVec[i].x;
                  _rule2.y = _setsPropVec[i].y + _setsPropVec[i].textHeight + 12;
               }
            }
            else
            {
               _setsPropVec[i].visible = false;
            }
            i++;
         }
         _thisHeight = _rule2.y + _rule2.height;
      }
      
      private function showButtomPart() : void
      {
         var k:int = 0;
         var i:int = 0;
         var containequip:* = null;
         var m:int = 0;
         var n:int = 0;
         var j:int = 0;
         var con:int = 0;
         var equipNum:Array = [];
         var equipArr:Array = [];
         for(k = 0; k < 19; )
         {
            _EquipInfo = _playerInfo.Bag.getItemAt(k);
            if(_EquipInfo != null)
            {
               equipArr.push([_EquipInfo.TemplateID,_EquipInfo.Place]);
            }
            k++;
         }
         for(i = 0; i < _ContainEquip.length; )
         {
            containequip = _ContainEquip[i].ContainEquip.split(",");
            loop2:
            for(m = 0; m < containequip.length; )
            {
               for(n = 0; n < equipArr.length; )
               {
                  if(equipArr[n][0] == containequip[m] && equipNum.indexOf(equipArr[n]) == -1)
                  {
                     equipNum.push(equipArr[n]);
                     break loop2;
                  }
                  n++;
               }
               m++;
            }
            i++;
         }
         for(j = 0; j < SUITNUM; )
         {
            if(_info["SkillDescribe" + (j + 1)] != "")
            {
               _validity[j].visible = true;
               con = _info["EqipCount" + (j + 1)];
               if(equipNum.length >= con)
               {
                  _validity[j].text = LanguageMgr.GetTranslation("ddt.goodTip.laterEquipmentGoodView.equip",con) + "\n    " + _info["SkillDescribe" + (j + 1)];
                  _validity[j].textColor = QualityType.QUALITY_COLOR[2];
                  if(!LaterEquipmentGoodView.isShow)
                  {
                     _validity[j].text = LanguageMgr.GetTranslation("ddt.goodTip.laterEquipmentGoodView.equip",con) + "\n    " + _info["SkillDescribe" + (j + 1)];
                     _validity[j].textColor = 10066329;
                  }
               }
               else
               {
                  _validity[j].text = LanguageMgr.GetTranslation("ddt.goodTip.laterEquipmentGoodView.equip",con) + "\n    " + _info["SkillDescribe" + (j + 1)];
                  _validity[j].textColor = 10066329;
                  if(!LaterEquipmentGoodView.isShow)
                  {
                     _validity[j].text = LanguageMgr.GetTranslation("ddt.goodTip.laterEquipmentGoodView.equip",con) + "\n    " + _info["SkillDescribe" + (j + 1)];
                     _validity[j].textColor = 10066329;
                  }
               }
            }
            else
            {
               _validity[j].visible = false;
            }
            _validity[j].y = _thisHeight + 4;
            _thisHeight = _validity[j].y + _validity[j].textHeight;
            _thisWidht = _thisWidht > _validity[j].x + _validity[j].textWidth?_thisWidht:_validity[j].x + _validity[j].textWidth;
            j++;
         }
         _setNum.text = "(" + equipNum.length + "/" + _ContainEquip.length + ")";
         _setNum.x = _topName.textWidth + 12;
         _setNum.y = _topName.y;
         if(!LaterEquipmentGoodView.isShow)
         {
            _setNum.text = "(0/" + _ContainEquip.length + ")";
            _setNum.textColor = 10066329;
         }
         _thisWidht = _thisWidht > _setNum.x + _setNum.width?_thisWidht:_setNum.x + _setNum.width;
      }
      
      private function upBackground() : void
      {
         _bg.height = _thisHeight + 13;
         _bg.width = _thisWidht + 13;
         updateWH();
      }
      
      private function updateWH() : void
      {
         _width = _bg.width;
         _height = _bg.height;
      }
      
      private function clear() : void
      {
         var j:int = 0;
         var i:int = 0;
         SUITNUM = 0;
         if(_setsPropVec && _setsPropVec.length > 0)
         {
            for(j = 0; j < _setsPropVec.length; )
            {
               _setsPropVec[j].dispose();
               _setsPropVec[j] = null;
               j++;
            }
            _setsPropVec = null;
         }
         if(_validity && _validity.length > 0)
         {
            for(i = 0; i < _validity.length; )
            {
               _validity[i].dispose();
               _validity[i] = null;
               i++;
            }
            _validity = null;
         }
      }
      
      public function getBGWidth() : int
      {
         return _bg.width;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_bg)
         {
            _bg.dispose();
            _bg = null;
         }
         if(_rule1)
         {
            _rule1.dispose();
            _rule1 = null;
         }
         if(_rule2)
         {
            _rule2.dispose();
            _rule2 = null;
         }
         if(_topName)
         {
            _topName.dispose();
            _topName = null;
         }
         if(_setNum)
         {
            _setNum.dispose();
            _setNum = null;
         }
         clear();
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
