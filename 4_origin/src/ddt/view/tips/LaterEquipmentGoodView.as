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
         var _loc1_:* = null;
         var _loc2_:int = 0;
         if(ItemManager.Instance.EquipSuit)
         {
            _loc1_ = ItemManager.Instance.EquipSuit[_info.SuitId] as Array;
            if(_loc1_)
            {
               SUITNUM = _loc1_.length;
            }
         }
         _setsPropVec = new Vector.<FilterFrameText>(SUITNUM);
         _validity = new Vector.<FilterFrameText>(SUITNUM);
         _loc2_ = 0;
         while(_loc2_ < SUITNUM)
         {
            _setsPropVec[_loc2_] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.setsPropText");
            _validity[_loc2_] = ComponentFactory.Instance.creatComponentByStylename("CardsTipPanel.setsPropText");
            _loc2_++;
         }
      }
      
      private function showText() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SUITNUM)
         {
            addChild(_setsPropVec[_loc1_]);
            addChild(_validity[_loc1_]);
            _loc1_++;
         }
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      override public function set tipData(param1:Object) : void
      {
         if(param1)
         {
            _itemInfo = param1 as ItemTemplateInfo;
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
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         _playerInfo = !!ItemManager.Instance.playerInfo?ItemManager.Instance.playerInfo:PlayerManager.Instance.Self;
         _ContainEquip = ItemManager.Instance.EquipSuit[_info.SuitId] as Array;
         if(_ContainEquip == null)
         {
            return;
         }
         var _loc2_:Array = [];
         var _loc6_:Array = [];
         var _loc5_:Array = [];
         var _loc12_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _ContainEquip.length)
         {
            if(_ContainEquip[_loc9_])
            {
               _loc7_ = ItemManager.Instance.getTemplateById(int(_ContainEquip[_loc9_]));
               _loc2_.push(_ContainEquip[_loc9_].PartName);
            }
            _loc9_++;
         }
         _loc10_ = 0;
         while(_loc10_ < 19)
         {
            _EquipInfo = _playerInfo.Bag.getItemAt(_loc10_);
            if(_EquipInfo != null)
            {
               _loc5_.push([_EquipInfo.TemplateID,_EquipInfo.Place]);
            }
            _loc10_++;
         }
         _loc11_ = 0;
         while(_loc11_ < _setsPropVec.length)
         {
            if(_loc11_ < _loc2_.length)
            {
               _setsPropVec[_loc11_].visible = true;
               _setsPropVec[_loc11_].text = _loc2_[_loc11_];
               _loc3_ = ItemManager.Instance.getEquipSuitbyContainEquip(_setsPropVec[_loc11_].text);
               _loc1_ = _loc3_.ContainEquip.split(",");
               _loc8_ = 0;
               loop3:
               while(_loc8_ < _loc5_.length)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc1_.length)
                  {
                     if(_loc1_[_loc4_] == _loc5_[_loc8_][0] && _loc12_.indexOf(_loc5_[_loc8_]) == -1)
                     {
                        _setsPropVec[_loc11_].textColor = 10092339;
                        _loc12_.push(_loc5_[_loc8_]);
                        break loop3;
                     }
                     _setsPropVec[_loc11_].textColor = 10066329;
                     _loc4_++;
                  }
                  _loc8_++;
               }
               if(!LaterEquipmentGoodView.isShow)
               {
                  _setsPropVec[_loc11_].textColor = 10066329;
               }
               if(!LaterEquipmentGoodView.isShow)
               {
                  _setsPropVec[_loc11_].textColor = 10066329;
               }
               _setsPropVec[_loc11_].y = _rule1.y + _rule1.height + 8 + 24 * _loc11_;
               if(_loc11_ == _loc2_.length - 1)
               {
                  _rule2.x = _setsPropVec[_loc11_].x;
                  _rule2.y = _setsPropVec[_loc11_].y + _setsPropVec[_loc11_].textHeight + 12;
               }
            }
            else
            {
               _setsPropVec[_loc11_].visible = false;
            }
            _loc11_++;
         }
         _thisHeight = _rule2.y + _rule2.height;
      }
      
      private function showButtomPart() : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:Array = [];
         var _loc2_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < 19)
         {
            _EquipInfo = _playerInfo.Bag.getItemAt(_loc8_);
            if(_EquipInfo != null)
            {
               _loc2_.push([_EquipInfo.TemplateID,_EquipInfo.Place]);
            }
            _loc8_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _ContainEquip.length)
         {
            _loc3_ = _ContainEquip[_loc9_].ContainEquip.split(",");
            _loc6_ = 0;
            loop2:
            while(_loc6_ < _loc3_.length)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc2_.length)
               {
                  if(_loc2_[_loc4_][0] == _loc3_[_loc6_] && _loc5_.indexOf(_loc2_[_loc4_]) == -1)
                  {
                     _loc5_.push(_loc2_[_loc4_]);
                     break loop2;
                  }
                  _loc4_++;
               }
               _loc6_++;
            }
            _loc9_++;
         }
         _loc7_ = 0;
         while(_loc7_ < SUITNUM)
         {
            if(_info["SkillDescribe" + (_loc7_ + 1)] != "")
            {
               _validity[_loc7_].visible = true;
               _loc1_ = _info["EqipCount" + (_loc7_ + 1)];
               if(_loc5_.length >= _loc1_)
               {
                  _validity[_loc7_].text = LanguageMgr.GetTranslation("ddt.goodTip.laterEquipmentGoodView.equip",_loc1_) + "\n    " + _info["SkillDescribe" + (_loc7_ + 1)];
                  _validity[_loc7_].textColor = QualityType.QUALITY_COLOR[2];
                  if(!LaterEquipmentGoodView.isShow)
                  {
                     _validity[_loc7_].text = LanguageMgr.GetTranslation("ddt.goodTip.laterEquipmentGoodView.equip",_loc1_) + "\n    " + _info["SkillDescribe" + (_loc7_ + 1)];
                     _validity[_loc7_].textColor = 10066329;
                  }
               }
               else
               {
                  _validity[_loc7_].text = LanguageMgr.GetTranslation("ddt.goodTip.laterEquipmentGoodView.equip",_loc1_) + "\n    " + _info["SkillDescribe" + (_loc7_ + 1)];
                  _validity[_loc7_].textColor = 10066329;
                  if(!LaterEquipmentGoodView.isShow)
                  {
                     _validity[_loc7_].text = LanguageMgr.GetTranslation("ddt.goodTip.laterEquipmentGoodView.equip",_loc1_) + "\n    " + _info["SkillDescribe" + (_loc7_ + 1)];
                     _validity[_loc7_].textColor = 10066329;
                  }
               }
            }
            else
            {
               _validity[_loc7_].visible = false;
            }
            _validity[_loc7_].y = _thisHeight + 4;
            _thisHeight = _validity[_loc7_].y + _validity[_loc7_].textHeight;
            _thisWidht = _thisWidht > _validity[_loc7_].x + _validity[_loc7_].textWidth?_thisWidht:_validity[_loc7_].x + _validity[_loc7_].textWidth;
            _loc7_++;
         }
         _setNum.text = "(" + _loc5_.length + "/" + _ContainEquip.length + ")";
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
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         SUITNUM = 0;
         if(_setsPropVec && _setsPropVec.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _setsPropVec.length)
            {
               _setsPropVec[_loc1_].dispose();
               _setsPropVec[_loc1_] = null;
               _loc1_++;
            }
            _setsPropVec = null;
         }
         if(_validity && _validity.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _validity.length)
            {
               _validity[_loc2_].dispose();
               _validity[_loc2_] = null;
               _loc2_++;
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
