package store.data
{
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.BagInfo;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import road7th.data.DictionaryEvent;
   import store.events.StoreBagEvent;
   import store.events.UpdateItemEvent;
   
   public class StoreModel extends EventDispatcher
   {
      
      private static const FORMULA_FLOCCULANT:int = 11301;
      
      private static const FORMULA_BIRD:int = 11201;
      
      private static const FORMULA_SNAKE:int = 11202;
      
      private static const FORMULA_DRAGON:int = 11203;
      
      private static const FORMULA_TIGER:int = 11204;
      
      private static const FORMULA_RING:int = 11302;
      
      private static const FORMULA_BANGLE:int = 11303;
      
      private static const RING_TIANYU:int = 9002;
      
      private static const RIN_GZHUFU:int = 8002;
      
      private static var _holeExpModel:HoleExpModel;
      
      public static var STORE_BAG:int = 1;
      
      public static var EVOLUTION_BAG:int = 2;
       
      
      private var _info:SelfInfo;
      
      private var _equipmentBag:DictionaryData;
      
      private var _propBag:DictionaryData;
      
      private var _canCpsEquipmentList:DictionaryData;
      
      private var _canStrthEqpmtList:DictionaryData;
      
      private var _canExaltEqpmtList:DictionaryData;
      
      private var _canExaltAssistantList:DictionaryData;
      
      private var _assistantEvolutionList:DictionaryData;
      
      private var _strthList:DictionaryData;
      
      private var _cpsAndANchList:DictionaryData;
      
      private var _cpsAndStrthAndformula:DictionaryData;
      
      private var _exaltRock:DictionaryData;
      
      private var _canRongLiangPropList:DictionaryData;
      
      private var _canTransEquipmengtList:DictionaryData;
      
      private var _canNotTransEquipmengtList:DictionaryData;
      
      private var _canRongLiangEquipmengtList:DictionaryData;
      
      private var _canLianhuaEquipList:DictionaryData;
      
      private var _canLianhuaPropList:DictionaryData;
      
      private var _canEmbedEquipList:DictionaryData;
      
      private var _canEmbedPropList:DictionaryData;
      
      private var _canGhostEquipList:DictionaryData;
      
      private var _canGhostPropList:DictionaryData;
      
      private var _currentPanel:int;
      
      private var _needAutoLink:int = 0;
      
      public function StoreModel(param1:PlayerInfo)
      {
         super();
         _info = param1 as SelfInfo;
         _equipmentBag = _info.Bag.items;
         _propBag = _info.PropBag.items;
         initData();
         initEvent();
      }
      
      public static function getHoleMaxLv() : int
      {
         if(_holeExpModel == null)
         {
            _holeExpModel = ComponentFactory.Instance.creatCustomObject("HoleExpModel");
         }
         return _holeExpModel.getMaxLv();
      }
      
      public static function getHoleMaxOpLv() : int
      {
         if(_holeExpModel == null)
         {
            _holeExpModel = ComponentFactory.Instance.creatCustomObject("HoleExpModel");
         }
         return _holeExpModel.getMaxOpLv();
      }
      
      public static function getHoleExpByLv(param1:int) : int
      {
         if(_holeExpModel == null)
         {
            _holeExpModel = ComponentFactory.Instance.creatCustomObject("HoleExpModel");
         }
         return _holeExpModel.getExpByLevel(param1);
      }
      
      private function initData() : void
      {
         _canStrthEqpmtList = new DictionaryData();
         _canCpsEquipmentList = new DictionaryData();
         _strthList = new DictionaryData();
         _cpsAndANchList = new DictionaryData();
         _canTransEquipmengtList = new DictionaryData();
         _canNotTransEquipmengtList = new DictionaryData();
         _canLianhuaEquipList = new DictionaryData();
         _canLianhuaPropList = new DictionaryData();
         _canEmbedEquipList = new DictionaryData();
         _canEmbedPropList = new DictionaryData();
         _canGhostEquipList = new DictionaryData();
         _canGhostPropList = new DictionaryData();
         _canRongLiangPropList = new DictionaryData();
         _exaltRock = new DictionaryData();
         _canExaltEqpmtList = new DictionaryData();
         _canExaltAssistantList = new DictionaryData();
         _assistantEvolutionList = new DictionaryData();
         _canRongLiangEquipmengtList = new DictionaryData();
         pickValidItemsOutOf(_equipmentBag,true);
         pickValidItemsOutOf(_propBag,false);
         _canStrthEqpmtList = sortEquipList(_canStrthEqpmtList);
         _canCpsEquipmentList = sortEquipList(_canCpsEquipmentList);
         _strthList = sortPropStrthList(_strthList);
         _cpsAndANchList = sortPropList(_cpsAndANchList,true);
         _canRongLiangPropList = sortPropList(_canRongLiangPropList);
         _canTransEquipmengtList = sortEquipList(_canTransEquipmengtList);
         _canNotTransEquipmengtList = sortEquipList(_canNotTransEquipmengtList);
         _canLianhuaEquipList = sortEquipList(_canLianhuaEquipList);
         _canLianhuaPropList = sortPropList(_canLianhuaPropList);
         _canEmbedEquipList = sortEquipList(_canEmbedEquipList);
         _canEmbedPropList = sortPropList(_canEmbedPropList);
         _canGhostEquipList = sortEquipList(_canGhostEquipList);
         _canExaltEqpmtList = sortEquipList(_canExaltEqpmtList);
         _canExaltAssistantList = sortOffHandList(_canExaltAssistantList);
         _canRongLiangEquipmengtList = sortRoogEquipList(_canRongLiangEquipmengtList);
      }
      
      private function pickValidItemsOutOf(param1:DictionaryData, param2:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(param2)
            {
               if(isProperTo_CanStrthEqpmtList(_loc3_))
               {
                  _canStrthEqpmtList.add(_canStrthEqpmtList.length,_loc3_);
               }
               if(isProperTo_CanCpsEquipmentList(_loc3_))
               {
                  _canCpsEquipmentList.add(_canCpsEquipmentList.length,_loc3_);
               }
               if(isProperTo_CanRongLiangEquipmengtList(_loc3_))
               {
                  _canRongLiangEquipmengtList.add(_canRongLiangEquipmengtList.length,_loc3_);
               }
               if(_loc3_.Quality >= 4 && (_loc3_.CanCompose || _loc3_.CanStrengthen || _loc3_.isCanLatentEnergy) || _loc3_.CategoryID == 70)
               {
                  if(isProperTo_CanTransEquipmengtList(_loc3_))
                  {
                     _canTransEquipmengtList.add(_canTransEquipmengtList.length,_loc3_);
                  }
                  else if(isProperTo_NotCanTransEquipmengtList(_loc3_))
                  {
                     _canNotTransEquipmengtList.add(_canNotTransEquipmengtList.length,_loc3_);
                  }
               }
               if(isProperTo_canLianhuaEquipList(_loc3_))
               {
                  _canLianhuaEquipList.add(_canLianhuaEquipList.length,_loc3_);
               }
               if(isProperTo_CanEmbedEquipList(_loc3_))
               {
                  _canEmbedEquipList.add(_canEmbedEquipList.length,_loc3_);
               }
               if(isProperTo_CanGhostEquipList(_loc3_))
               {
                  _canGhostEquipList.add(_canGhostEquipList.length,_loc3_);
               }
               if(isProperTo_CanExaltEqpmtList(_loc3_))
               {
                  _canExaltEqpmtList.add(_canExaltEqpmtList.length,_loc3_);
               }
               if(isPropreTo_CanExaltAssistantList(_loc3_))
               {
                  _canExaltAssistantList.add(_canExaltAssistantList.length,_loc3_);
               }
            }
            else
            {
               if(isProperTo_StrthList(_loc3_))
               {
                  _strthList.add(_strthList.length,_loc3_);
               }
               if(isProperTo_CpsAndANchList(_loc3_))
               {
                  _cpsAndANchList.add(_cpsAndANchList.length,_loc3_);
               }
               if(isProperTo_canLianhuaPropList(_loc3_))
               {
                  _canLianhuaPropList.add(_canLianhuaPropList.length,_loc3_);
               }
               if(isProperTo_CanEmbedPropList(_loc3_))
               {
                  _canEmbedPropList.add(_canEmbedPropList.length,_loc3_);
               }
               if(isProperTo_CanGhostPropList(_loc3_))
               {
                  _canGhostPropList.add(_canGhostPropList.length,_loc3_);
               }
               if(isProperTo_canRongLiangProperList(_loc3_))
               {
                  _canRongLiangPropList.add(_canRongLiangPropList.length,_loc3_);
               }
               if(isProperTo_ExaltList(_loc3_))
               {
                  _exaltRock.add(_exaltRock.length,_loc3_);
               }
               if(isEvolutionMaterial(_loc3_))
               {
                  _assistantEvolutionList.add(_assistantEvolutionList.length,_loc3_);
               }
            }
         }
      }
      
      private function isProperTo_canRongLiangProperList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.Property1 == "8")
         {
            return true;
         }
         if(param1.FusionType != 0 && param1.getRemainDate() > 0)
         {
            return true;
         }
         return false;
      }
      
      private function initEvent() : void
      {
         _info.PropBag.addEventListener("update",updateBag);
         _info.Bag.addEventListener("update",updateBag);
      }
      
      private function updateBag(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:BagInfo = param1.target as BagInfo;
         var _loc5_:Dictionary = param1.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = _loc5_;
         for each(var _loc4_ in _loc5_)
         {
            _loc2_ = _loc3_.getItemAt(_loc4_.Place);
            if(_loc2_)
            {
               if(_loc3_.BagType == 0)
               {
                  __updateEquip(_loc2_);
               }
               else if(_loc3_.BagType == 1)
               {
                  __updateProp(_loc2_);
               }
            }
            else if(_loc3_.BagType == 0)
            {
               removeFrom(_loc4_,_canStrthEqpmtList);
               removeFrom(_loc4_,_canCpsEquipmentList);
               removeFrom(_loc4_,_canTransEquipmengtList);
               removeFrom(_loc4_,_canNotTransEquipmengtList);
               removeFrom(_loc4_,_canLianhuaEquipList);
               removeFrom(_loc4_,_canEmbedEquipList);
               removeFrom(_loc4_,_canGhostEquipList);
               removeFrom(_loc4_,_canRongLiangEquipmengtList);
               removeFrom(_loc4_,_canExaltEqpmtList);
               removeFrom(_loc4_,_canExaltAssistantList);
            }
            else
            {
               removeFrom(_loc4_,_strthList);
               removeFrom(_loc4_,_cpsAndANchList);
               removeFrom(_loc4_,_canRongLiangPropList);
               removeFrom(_loc4_,_canLianhuaPropList);
               removeFrom(_loc4_,_canEmbedPropList);
               removeFrom(_loc4_,_exaltRock);
               removeFrom(_loc4_,_assistantEvolutionList);
               removeFrom(_loc4_,_canGhostPropList);
            }
         }
      }
      
      private function __updateEquip(param1:InventoryItemInfo) : void
      {
         if(isProperTo_CanStrthEqpmtList(param1))
         {
            updateDic(_canStrthEqpmtList,param1);
         }
         else
         {
            removeFrom(param1,_canStrthEqpmtList);
         }
         if(isProperTo_CanCpsEquipmentList(param1))
         {
            updateDic(_canCpsEquipmentList,param1);
         }
         else
         {
            removeFrom(param1,_canCpsEquipmentList);
         }
         if(isProperTo_CanTransEquipmengtList(param1))
         {
            updateDic(_canTransEquipmengtList,param1);
         }
         else
         {
            removeFrom(param1,_canTransEquipmengtList);
         }
         if(isProperTo_NotCanTransEquipmengtList(param1))
         {
            updateDic(_canNotTransEquipmengtList,param1);
         }
         else
         {
            removeFrom(param1,_canNotTransEquipmengtList);
         }
         if(isProperTo_CanRongLiangEquipmengtList(param1))
         {
            updateDic(_canRongLiangEquipmengtList,param1);
         }
         else
         {
            removeFrom(param1,_canRongLiangEquipmengtList);
         }
         if(isProperTo_canLianhuaEquipList(param1))
         {
            updateDic(_canLianhuaEquipList,param1);
         }
         else
         {
            removeFrom(param1,_canLianhuaEquipList);
         }
         if(isProperTo_CanEmbedEquipList(param1))
         {
            updateDic(_canEmbedEquipList,param1);
         }
         else
         {
            removeFrom(param1,_canEmbedEquipList);
         }
         if(isProperTo_CanGhostEquipList(param1))
         {
            updateDic(_canGhostEquipList,param1);
         }
         else
         {
            removeFrom(param1,_canGhostEquipList);
         }
         if(isProperTo_CanExaltEqpmtList(param1))
         {
            updateDic(_canExaltEqpmtList,param1);
         }
         else
         {
            removeFrom(param1,_canExaltEqpmtList);
         }
         if(isPropreTo_CanExaltAssistantList(param1))
         {
            updateDic(_canExaltAssistantList,param1);
         }
         else
         {
            removeFrom(param1,_canExaltAssistantList);
         }
      }
      
      private function __updateProp(param1:InventoryItemInfo) : void
      {
         if(isProperTo_CpsAndANchList(param1))
         {
            updateDic(_cpsAndANchList,param1);
         }
         else
         {
            removeFrom(param1,_cpsAndANchList);
         }
         if(isProperTo_canRongLiangProperList(param1))
         {
            updateDic(_canRongLiangPropList,param1);
         }
         else
         {
            removeFrom(param1,_canRongLiangPropList);
         }
         if(isProperTo_StrthList(param1))
         {
            updateDic(_strthList,param1);
         }
         else
         {
            removeFrom(param1,_strthList);
         }
         if(isProperTo_ExaltList(param1))
         {
            updateDic(_exaltRock,param1);
         }
         else
         {
            removeFrom(param1,_exaltRock);
         }
         if(isProperTo_canLianhuaPropList(param1))
         {
            updateDic(_canLianhuaPropList,param1);
         }
         else
         {
            removeFrom(param1,_canLianhuaPropList);
         }
         if(isProperTo_CanEmbedPropList(param1))
         {
            updateDic(_canEmbedPropList,param1);
         }
         else
         {
            removeFrom(param1,_canEmbedPropList);
         }
         if(isEvolutionMaterial(param1))
         {
            updateDic(_assistantEvolutionList,param1);
         }
         else
         {
            removeFrom(param1,_assistantEvolutionList);
         }
         if(isProperTo_CanGhostPropList(param1))
         {
            updateDic(_canGhostPropList,param1);
         }
         else
         {
            removeFrom(param1,_canGhostPropList);
         }
      }
      
      private function isProperTo_CanCpsEquipmentList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.CanCompose && param1.getRemainDate() > 0)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanStrthEqpmtList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.CanStrengthen && param1.getRemainDate() > 0)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanExaltEqpmtList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.CanStrengthen && param1.getRemainDate() > 0 && param1.StrengthenLevel >= 12)
         {
            return true;
         }
         return false;
      }
      
      private function isPropreTo_CanExaltAssistantList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.getRemainDate() > 0 && param1.CategoryID == 17 && (param1.Property3 == "32" || param1.Property3 == "31") && int(param1.Property2) > 0)
         {
            return true;
         }
         return false;
      }
      
      private function isEvolutionMaterial(param1:InventoryItemInfo) : Boolean
      {
         if(param1.TemplateID == 12572)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_StrthList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.getRemainDate() <= 0)
         {
            return false;
         }
         if(EquipType.isStrengthStone(param1))
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_ExaltList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.getRemainDate() <= 0)
         {
            return false;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "45")
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CpsAndANchList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.getRemainDate() <= 0)
         {
            return false;
         }
         if(EquipType.isComposeStone(param1) || param1.CategoryID == 11 && param1.Property1 == "3")
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CpsAndStrthAndformula(param1:InventoryItemInfo) : Boolean
      {
         if(param1.getRemainDate() <= 0)
         {
            return false;
         }
         if(param1.FusionType != 0)
         {
            return true;
         }
         if(EquipType.isComposeStone(param1) || param1.CategoryID == 11 && param1.Property1 == "8" || EquipType.isStrengthStone(param1))
         {
            return true;
         }
         if(param1.CategoryID == 11 && param1.Property1 == "31")
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanRongLiangEquipmengtList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.FusionType != 0 && param1.getRemainDate() > 0 && param1.FusionRate > 0)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_canLianhuaEquipList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.RefineryLevel >= 0 && param1.getRemainDate() >= 0)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_canLianhuaPropList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.getRemainDate() <= 0)
         {
            return false;
         }
         if(param1.CategoryID == 11 && (param1.Property1 == "32" || param1.Property1 == "33") || param1.CategoryID == 11 && param1.Property1 == "3")
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanTransEquipmengtList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.CategoryID == 27)
         {
            return false;
         }
         if(param1.CategoryID == 70)
         {
            if(param1.StrengthenLevel > 1 || param1.StrengthenExp > 0)
            {
               return true;
            }
            return false;
         }
         if(param1.StrengthenLevel > 0 || param1.AttackCompose > 0 || param1.DefendCompose > 0 || param1.AgilityCompose > 0 || param1.LuckCompose > 0 || param1.isHasLatentEnergy || param1.isCanEnchant() && param1.MagicLevel > 0)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_NotCanTransEquipmengtList(param1:InventoryItemInfo) : Boolean
      {
         if(!isProperTo_CanTransEquipmengtList(param1))
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanEmbedEquipList(param1:InventoryItemInfo) : Boolean
      {
         var _loc2_:* = null;
         if(param1.getRemainDate() <= 0 || param1.CategoryID == 27)
         {
            return false;
         }
         var _loc3_:Array = param1.Hole.split("|");
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = _loc4_.split(",");
            if(_loc2_[1] == "-1")
            {
               return false;
            }
         }
         return true;
      }
      
      private function isProperTo_CanGhostEquipList(param1:InventoryItemInfo) : Boolean
      {
         var _loc2_:Array = [1,5,7];
         if(param1.Place > 30 || _loc2_.lastIndexOf(param1.CategoryID) == -1)
         {
            return false;
         }
         var _loc3_:InventoryItemInfo = PlayerManager.Instance.Self.Bag.getItemAt(param1.Place);
         return _loc3_ != null;
      }
      
      private function isProperTo_CanEmbedPropList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.getRemainDate() <= 0)
         {
            return false;
         }
         if(EquipType.isDrill(param1))
         {
            return true;
         }
         if(param1.CategoryID == 11 && (param1.Property1 == "31" || param1.Property1 == "16"))
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanGhostPropList(param1:InventoryItemInfo) : Boolean
      {
         if(param1.CategoryID == 11 && (param1.Property1 == "117" || param1.Property1 == "118"))
         {
            return true;
         }
         return false;
      }
      
      private function updateDic(param1:DictionaryData, param2:InventoryItemInfo) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] != null && param1[_loc3_].Place == param2.Place)
            {
               param1.add(_loc3_,param2);
               param1.dispatchEvent(new UpdateItemEvent("updateItemEvent",_loc3_,param2));
               return;
            }
            _loc3_++;
         }
         addItemToTheFirstNullCell(param2,param1);
      }
      
      private function __removeEquip(param1:DictionaryEvent) : void
      {
         var _loc2_:InventoryItemInfo = param1.data as InventoryItemInfo;
         removeFrom(_loc2_,_canCpsEquipmentList);
         removeFrom(_loc2_,_canStrthEqpmtList);
         removeFrom(_loc2_,_canTransEquipmengtList);
         removeFrom(_loc2_,_canRongLiangEquipmengtList);
      }
      
      private function addItemToTheFirstNullCell(param1:InventoryItemInfo, param2:DictionaryData) : void
      {
         param2.add(findFirstNullCellID(param2),param1);
      }
      
      private function findFirstNullCellID(param1:DictionaryData) : int
      {
         var _loc4_:int = 0;
         var _loc2_:* = -1;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ <= _loc3_)
         {
            if(param1[_loc4_] == null)
            {
               _loc2_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function removeFrom(param1:InventoryItemInfo, param2:DictionaryData) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = param2.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param2[_loc4_] && param2[_loc4_].Place == param1.Place)
            {
               param2[_loc4_] = null;
               param2.dispatchEvent(new StoreBagEvent("storeBagRemove",_loc4_,param1));
               break;
            }
            _loc4_++;
         }
      }
      
      public function sortEquipList(param1:DictionaryData) : DictionaryData
      {
         var _loc2_:* = param1;
         param1 = new DictionaryData();
         fillByCategoryID(_loc2_,param1,7);
         fillByCategoryID(_loc2_,param1,5);
         fillByCategoryID(_loc2_,param1,1);
         fillByCategoryID(_loc2_,param1,2);
         fillByCategoryID(_loc2_,param1,3);
         fillByCategoryID(_loc2_,param1,4);
         fillByCategoryID(_loc2_,param1,6);
         fillByCategoryID(_loc2_,param1,13);
         fillByCategoryID(_loc2_,param1,15);
         fillByCategoryID(_loc2_,param1,8);
         fillByCategoryID(_loc2_,param1,9);
         fillByCategoryID(_loc2_,param1,17);
         fillByCategoryID(_loc2_,param1,70);
         param1 = sortByIsUsed(param1);
         return param1;
      }
      
      private function sortByIsUsed(param1:DictionaryData) : DictionaryData
      {
         var _loc5_:DictionaryData = new DictionaryData();
         var _loc3_:DictionaryData = new DictionaryData();
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc2_ in param1)
         {
            if(_loc2_.Place < 17 || _loc2_.Place == 18)
            {
               _loc5_.add(_loc5_.length,_loc2_);
            }
            else
            {
               _loc3_.add(_loc3_.length,_loc2_);
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = _loc3_;
         for each(var _loc4_ in _loc3_)
         {
            _loc5_.add(_loc5_.length,_loc4_);
         }
         return _loc5_;
      }
      
      public function sortRoogEquipList(param1:DictionaryData) : DictionaryData
      {
         var _loc2_:* = param1;
         param1 = new DictionaryData();
         rongLiangFill(_loc2_,param1,7);
         rongLiangFill(_loc2_,param1,17);
         rongLiangFill(_loc2_,param1,8);
         rongLiangFill(_loc2_,param1,9);
         rongLiangFill(_loc2_,param1,14);
         rongLiangFill(_loc2_,param1,70);
         return param1;
      }
      
      private function fillByCategoryID(param1:DictionaryData, param2:DictionaryData, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            if(_loc4_.CategoryID == param3)
            {
               param2.add(param2.length,_loc4_);
            }
         }
      }
      
      private function rongLiangFill(param1:DictionaryData, param2:DictionaryData, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            if(_loc4_.CategoryID == param3)
            {
               param2.add(param2.length,_loc4_);
            }
         }
      }
      
      private function rongLiangFunFill(param1:DictionaryData, param2:DictionaryData) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(_loc3_.Property1 == "8")
            {
               param2.add(param2.length,_loc3_);
            }
         }
      }
      
      private function fillByTemplateID(param1:DictionaryData, param2:DictionaryData, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            if(_loc4_.TemplateID == param3)
            {
               param2.add(param2.length,_loc4_);
            }
         }
      }
      
      private function fillByProperty1AndProperty3(param1:DictionaryData, param2:DictionaryData, param3:String, param4:String) : void
      {
         var _loc6_:* = null;
         var _loc5_:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(_loc6_ in param1)
         {
            if(_loc6_.Property1 == param3 && _loc6_.Property3 == param4)
            {
               _loc5_.push(_loc6_);
            }
         }
         bubbleSort(_loc5_);
         var _loc10_:int = 0;
         var _loc9_:* = _loc5_;
         for each(_loc6_ in _loc5_)
         {
            param2.add(param2.length,_loc6_);
         }
      }
      
      private function fillByProperty1(param1:DictionaryData, param2:DictionaryData, param3:String) : void
      {
         var _loc5_:* = null;
         var _loc4_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(_loc5_ in param1)
         {
            if(_loc5_.Property1 == param3)
            {
               _loc4_.push(_loc5_);
            }
         }
         bubbleSort(_loc4_);
         var _loc9_:int = 0;
         var _loc8_:* = _loc4_;
         for each(_loc5_ in _loc4_)
         {
            param2.add(param2.length,_loc5_);
         }
      }
      
      private function findByTemplateID(param1:DictionaryData, param2:DictionaryData, param3:int) : void
      {
         var _loc5_:* = null;
         var _loc4_:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(_loc5_ in param1)
         {
            if(_loc5_.TemplateID == param3)
            {
               _loc4_.push(_loc5_);
            }
         }
         bubbleSort(_loc4_);
         var _loc9_:int = 0;
         var _loc8_:* = _loc4_;
         for each(_loc5_ in _loc4_)
         {
            param2.add(param2.length,_loc5_);
         }
      }
      
      public function sortOffHandList(param1:DictionaryData) : DictionaryData
      {
         var _loc2_:* = param1;
         param1 = new DictionaryData();
         rongLiangFunFill(_loc2_,param1);
         fillOffHand(_loc2_,param1,17);
         return param1;
      }
      
      private function fillOffHand(param1:DictionaryData, param2:DictionaryData, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            if(_loc4_.CategoryID == param3 && (_loc4_.Property3 == "32" || _loc4_.Property3 == "31"))
            {
               param2.add(param2.length,_loc4_);
            }
         }
      }
      
      public function sortEvolutionMaterialList(param1:DictionaryData) : DictionaryData
      {
         var _loc2_:* = param1;
         param1 = new DictionaryData();
         rongLiangFunFill(_loc2_,param1);
         fillByCategoryID(_loc2_,param1,12572);
         return param1;
      }
      
      public function sortPropList(param1:DictionaryData, param2:Boolean = false) : DictionaryData
      {
         var _loc3_:* = param1;
         param1 = new DictionaryData();
         rongLiangFunFill(_loc3_,param1);
         fillByProperty1(_loc3_,param1,"2");
         fillByProperty1(_loc3_,param1,"35");
         fillByProperty1(_loc3_,param1,"32");
         fillByProperty1(_loc3_,param1,"33");
         fillByProperty1(_loc3_,param1,"16");
         fillByProperty1(_loc3_,param1,"31");
         fillByProperty1AndProperty3(_loc3_,param1,"1","1");
         fillByProperty1AndProperty3(_loc3_,param1,"1","2");
         fillByProperty1AndProperty3(_loc3_,param1,"1","3");
         fillByProperty1AndProperty3(_loc3_,param1,"1","4");
         if(!param2)
         {
            fillByProperty1(_loc3_,param1,"7");
         }
         fillByProperty1(_loc3_,param1,"3");
         rongLiangFill(_loc3_,param1,8);
         rongLiangFill(_loc3_,param1,9);
         rongLiangFill(_loc3_,param1,14);
         fillByProperty1(_loc3_,param1,"10");
         return param1;
      }
      
      public function sortPropStrthList(param1:DictionaryData, param2:Boolean = false) : DictionaryData
      {
         var _loc3_:* = param1;
         param1 = new DictionaryData();
         rongLiangFunFill(_loc3_,param1);
         fillByProperty1(_loc3_,param1,"2");
         fillByProperty1(_loc3_,param1,"35");
         fillByProperty1(_loc3_,param1,"32");
         fillByProperty1(_loc3_,param1,"33");
         fillByProperty1(_loc3_,param1,"16");
         fillByProperty1(_loc3_,param1,"31");
         fillByProperty1AndProperty3(_loc3_,param1,"1","1");
         fillByProperty1AndProperty3(_loc3_,param1,"1","2");
         fillByProperty1AndProperty3(_loc3_,param1,"1","3");
         fillByProperty1AndProperty3(_loc3_,param1,"1","4");
         rongLiangFill(_loc3_,param1,8);
         rongLiangFill(_loc3_,param1,9);
         rongLiangFill(_loc3_,param1,14);
         fillByProperty1(_loc3_,param1,"10");
         return param1;
      }
      
      private function bubbleSort(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc3_:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = true;
            _loc5_ = 0;
            while(_loc5_ < _loc2_ - 1)
            {
               if(param1[_loc5_].Quality < param1[_loc5_ + 1].Quality)
               {
                  _loc4_ = param1[_loc5_];
                  param1[_loc5_] = param1[_loc5_ + 1];
                  param1[_loc5_ + 1] = _loc4_;
                  _loc3_ = false;
               }
               _loc5_++;
            }
            if(_loc3_)
            {
               return;
            }
            _loc6_++;
         }
      }
      
      public function get info() : PlayerInfo
      {
         return _info;
      }
      
      public function set currentPanel(param1:int) : void
      {
         _currentPanel = param1;
      }
      
      public function get currentPanel() : int
      {
         return this._currentPanel;
      }
      
      public function get canCpsEquipmentList() : DictionaryData
      {
         return this._canCpsEquipmentList;
      }
      
      public function get canExaltEqpmtList() : DictionaryData
      {
         return this._canExaltEqpmtList;
      }
      
      public function get canExaltAssistEqpmtList() : DictionaryData
      {
         return this._canExaltAssistantList;
      }
      
      public function get evolutionMaterialList() : DictionaryData
      {
         return this._assistantEvolutionList;
      }
      
      public function get canLianhuaEquipList() : DictionaryData
      {
         return this._canLianhuaEquipList;
      }
      
      public function get canLianhuaPropList() : DictionaryData
      {
         return this._canLianhuaPropList;
      }
      
      public function get canStrthEqpmtList() : DictionaryData
      {
         return this._canStrthEqpmtList;
      }
      
      public function get strthList() : DictionaryData
      {
         return this._strthList;
      }
      
      public function get exaltRock() : DictionaryData
      {
         return this._exaltRock;
      }
      
      public function get cpsAndANchList() : DictionaryData
      {
         return this._cpsAndANchList;
      }
      
      public function get cpsAndStrthAndformula() : DictionaryData
      {
         return this._cpsAndStrthAndformula;
      }
      
      public function get canRongLiangPropList() : DictionaryData
      {
         return this._canRongLiangPropList;
      }
      
      public function get canTransEquipmengtList() : DictionaryData
      {
         return this._canTransEquipmengtList;
      }
      
      public function get canNotTransEquipmengtList() : DictionaryData
      {
         return this._canNotTransEquipmengtList;
      }
      
      public function get canRongLiangEquipmengtList() : DictionaryData
      {
         return this._canRongLiangEquipmengtList;
      }
      
      public function get canEmbedEquipList() : DictionaryData
      {
         return _canEmbedEquipList;
      }
      
      public function get canEmbedPropList() : DictionaryData
      {
         return _canEmbedPropList;
      }
      
      public function get canGhostEquipList() : DictionaryData
      {
         return _canGhostEquipList;
      }
      
      public function get canGhostPropList() : DictionaryData
      {
         return _canGhostPropList;
      }
      
      public function set NeedAutoLink(param1:int) : void
      {
         _needAutoLink = param1;
      }
      
      public function get NeedAutoLink() : int
      {
         return _needAutoLink;
      }
      
      public function checkEmbeded() : Boolean
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _canEmbedEquipList;
         for(var _loc2_ in _canEmbedEquipList)
         {
            _loc1_ = _canEmbedEquipList[int(_loc2_)] as InventoryItemInfo;
            if(_loc1_ && _loc1_.Hole1 != -1 && _loc1_.Hole1 != 0)
            {
               return false;
            }
            if(_loc1_ && _loc1_.Hole2 != -1 && _loc1_.Hole2 != 0)
            {
               return false;
            }
            if(_loc1_ && _loc1_.Hole3 != -1 && _loc1_.Hole3 != 0)
            {
               return false;
            }
            if(_loc1_ && _loc1_.Hole4 != -1 && _loc1_.Hole4 != 0)
            {
               return false;
            }
            if(_loc1_ && _loc1_.Hole5 != -1 && _loc1_.Hole5 != 0)
            {
               return false;
            }
            if(_loc1_ && _loc1_.Hole6 != -1 && _loc1_.Hole6 != 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public function loadBagData() : void
      {
         initData();
      }
      
      public function clear() : void
      {
         _info.PropBag.removeEventListener("update",updateBag);
         _info.Bag.removeEventListener("update",updateBag);
         _info = null;
         _propBag = null;
         _equipmentBag = null;
      }
   }
}
