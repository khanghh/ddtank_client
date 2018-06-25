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
      
      public function StoreModel(info:PlayerInfo)
      {
         super();
         _info = info as SelfInfo;
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
      
      public static function getHoleExpByLv(lv:int) : int
      {
         if(_holeExpModel == null)
         {
            _holeExpModel = ComponentFactory.Instance.creatCustomObject("HoleExpModel");
         }
         return _holeExpModel.getExpByLevel(lv);
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
      
      private function pickValidItemsOutOf(bag:DictionaryData, isEquip:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = bag;
         for each(var item in bag)
         {
            if(isEquip)
            {
               if(isProperTo_CanStrthEqpmtList(item))
               {
                  _canStrthEqpmtList.add(_canStrthEqpmtList.length,item);
               }
               if(isProperTo_CanCpsEquipmentList(item))
               {
                  _canCpsEquipmentList.add(_canCpsEquipmentList.length,item);
               }
               if(isProperTo_CanRongLiangEquipmengtList(item))
               {
                  _canRongLiangEquipmengtList.add(_canRongLiangEquipmengtList.length,item);
               }
               if(item.Quality >= 4 && (item.CanCompose || item.CanStrengthen || item.isCanLatentEnergy) || item.CategoryID == 70)
               {
                  if(isProperTo_CanTransEquipmengtList(item))
                  {
                     _canTransEquipmengtList.add(_canTransEquipmengtList.length,item);
                  }
                  else if(isProperTo_NotCanTransEquipmengtList(item))
                  {
                     _canNotTransEquipmengtList.add(_canNotTransEquipmengtList.length,item);
                  }
               }
               if(isProperTo_canLianhuaEquipList(item))
               {
                  _canLianhuaEquipList.add(_canLianhuaEquipList.length,item);
               }
               if(isProperTo_CanEmbedEquipList(item))
               {
                  _canEmbedEquipList.add(_canEmbedEquipList.length,item);
               }
               if(isProperTo_CanGhostEquipList(item))
               {
                  _canGhostEquipList.add(_canGhostEquipList.length,item);
               }
               if(isProperTo_CanExaltEqpmtList(item))
               {
                  _canExaltEqpmtList.add(_canExaltEqpmtList.length,item);
               }
               if(isPropreTo_CanExaltAssistantList(item))
               {
                  _canExaltAssistantList.add(_canExaltAssistantList.length,item);
               }
            }
            else
            {
               if(isProperTo_StrthList(item))
               {
                  _strthList.add(_strthList.length,item);
               }
               if(isProperTo_CpsAndANchList(item))
               {
                  _cpsAndANchList.add(_cpsAndANchList.length,item);
               }
               if(isProperTo_canLianhuaPropList(item))
               {
                  _canLianhuaPropList.add(_canLianhuaPropList.length,item);
               }
               if(isProperTo_CanEmbedPropList(item))
               {
                  _canEmbedPropList.add(_canEmbedPropList.length,item);
               }
               if(isProperTo_CanGhostPropList(item))
               {
                  _canGhostPropList.add(_canGhostPropList.length,item);
               }
               if(isProperTo_canRongLiangProperList(item))
               {
                  _canRongLiangPropList.add(_canRongLiangPropList.length,item);
               }
               if(isProperTo_ExaltList(item))
               {
                  _exaltRock.add(_exaltRock.length,item);
               }
               if(isEvolutionMaterial(item))
               {
                  _assistantEvolutionList.add(_assistantEvolutionList.length,item);
               }
            }
         }
      }
      
      private function isProperTo_canRongLiangProperList(item:InventoryItemInfo) : Boolean
      {
         if(item.Property1 == "8")
         {
            return true;
         }
         if(item.FusionType != 0 && item.getRemainDate() > 0)
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
      
      private function updateBag(evt:BagEvent) : void
      {
         var c:* = null;
         var bag:BagInfo = evt.target as BagInfo;
         var changes:Dictionary = evt.changedSlots;
         var _loc7_:int = 0;
         var _loc6_:* = changes;
         for each(var i in changes)
         {
            c = bag.getItemAt(i.Place);
            if(c)
            {
               if(bag.BagType == 0)
               {
                  __updateEquip(c);
               }
               else if(bag.BagType == 1)
               {
                  __updateProp(c);
               }
            }
            else if(bag.BagType == 0)
            {
               removeFrom(i,_canStrthEqpmtList);
               removeFrom(i,_canCpsEquipmentList);
               removeFrom(i,_canTransEquipmengtList);
               removeFrom(i,_canNotTransEquipmengtList);
               removeFrom(i,_canLianhuaEquipList);
               removeFrom(i,_canEmbedEquipList);
               removeFrom(i,_canGhostEquipList);
               removeFrom(i,_canRongLiangEquipmengtList);
               removeFrom(i,_canExaltEqpmtList);
               removeFrom(i,_canExaltAssistantList);
            }
            else
            {
               removeFrom(i,_strthList);
               removeFrom(i,_cpsAndANchList);
               removeFrom(i,_canRongLiangPropList);
               removeFrom(i,_canLianhuaPropList);
               removeFrom(i,_canEmbedPropList);
               removeFrom(i,_exaltRock);
               removeFrom(i,_assistantEvolutionList);
               removeFrom(i,_canGhostPropList);
            }
         }
      }
      
      private function __updateEquip(item:InventoryItemInfo) : void
      {
         if(isProperTo_CanStrthEqpmtList(item))
         {
            updateDic(_canStrthEqpmtList,item);
         }
         else
         {
            removeFrom(item,_canStrthEqpmtList);
         }
         if(isProperTo_CanCpsEquipmentList(item))
         {
            updateDic(_canCpsEquipmentList,item);
         }
         else
         {
            removeFrom(item,_canCpsEquipmentList);
         }
         if(isProperTo_CanTransEquipmengtList(item))
         {
            updateDic(_canTransEquipmengtList,item);
         }
         else
         {
            removeFrom(item,_canTransEquipmengtList);
         }
         if(isProperTo_NotCanTransEquipmengtList(item))
         {
            updateDic(_canNotTransEquipmengtList,item);
         }
         else
         {
            removeFrom(item,_canNotTransEquipmengtList);
         }
         if(isProperTo_CanRongLiangEquipmengtList(item))
         {
            updateDic(_canRongLiangEquipmengtList,item);
         }
         else
         {
            removeFrom(item,_canRongLiangEquipmengtList);
         }
         if(isProperTo_canLianhuaEquipList(item))
         {
            updateDic(_canLianhuaEquipList,item);
         }
         else
         {
            removeFrom(item,_canLianhuaEquipList);
         }
         if(isProperTo_CanEmbedEquipList(item))
         {
            updateDic(_canEmbedEquipList,item);
         }
         else
         {
            removeFrom(item,_canEmbedEquipList);
         }
         if(isProperTo_CanGhostEquipList(item))
         {
            updateDic(_canGhostEquipList,item);
         }
         else
         {
            removeFrom(item,_canGhostEquipList);
         }
         if(isProperTo_CanExaltEqpmtList(item))
         {
            updateDic(_canExaltEqpmtList,item);
         }
         else
         {
            removeFrom(item,_canExaltEqpmtList);
         }
         if(isPropreTo_CanExaltAssistantList(item))
         {
            updateDic(_canExaltAssistantList,item);
         }
         else
         {
            removeFrom(item,_canExaltAssistantList);
         }
      }
      
      private function __updateProp(item:InventoryItemInfo) : void
      {
         if(isProperTo_CpsAndANchList(item))
         {
            updateDic(_cpsAndANchList,item);
         }
         else
         {
            removeFrom(item,_cpsAndANchList);
         }
         if(isProperTo_canRongLiangProperList(item))
         {
            updateDic(_canRongLiangPropList,item);
         }
         else
         {
            removeFrom(item,_canRongLiangPropList);
         }
         if(isProperTo_StrthList(item))
         {
            updateDic(_strthList,item);
         }
         else
         {
            removeFrom(item,_strthList);
         }
         if(isProperTo_ExaltList(item))
         {
            updateDic(_exaltRock,item);
         }
         else
         {
            removeFrom(item,_exaltRock);
         }
         if(isProperTo_canLianhuaPropList(item))
         {
            updateDic(_canLianhuaPropList,item);
         }
         else
         {
            removeFrom(item,_canLianhuaPropList);
         }
         if(isProperTo_CanEmbedPropList(item))
         {
            updateDic(_canEmbedPropList,item);
         }
         else
         {
            removeFrom(item,_canEmbedPropList);
         }
         if(isEvolutionMaterial(item))
         {
            updateDic(_assistantEvolutionList,item);
         }
         else
         {
            removeFrom(item,_assistantEvolutionList);
         }
         if(isProperTo_CanGhostPropList(item))
         {
            updateDic(_canGhostPropList,item);
         }
         else
         {
            removeFrom(item,_canGhostPropList);
         }
      }
      
      private function isProperTo_CanCpsEquipmentList(item:InventoryItemInfo) : Boolean
      {
         if(item.CanCompose && item.getRemainDate() > 0)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanStrthEqpmtList(item:InventoryItemInfo) : Boolean
      {
         if(item.CanStrengthen && item.getRemainDate() > 0)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanExaltEqpmtList(item:InventoryItemInfo) : Boolean
      {
         if(item.CanStrengthen && item.getRemainDate() > 0 && item.StrengthenLevel >= 12)
         {
            return true;
         }
         return false;
      }
      
      private function isPropreTo_CanExaltAssistantList(item:InventoryItemInfo) : Boolean
      {
         if(item.getRemainDate() > 0 && item.CategoryID == 17 && (item.Property3 == "32" || item.Property3 == "31" || item.Property3 == "132") && int(item.Property2) > 0)
         {
            return true;
         }
         return false;
      }
      
      private function isEvolutionMaterial(item:InventoryItemInfo) : Boolean
      {
         if(item.TemplateID == 12572)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_StrthList(item:InventoryItemInfo) : Boolean
      {
         if(item.getRemainDate() <= 0)
         {
            return false;
         }
         if(EquipType.isStrengthStone(item))
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_ExaltList(item:InventoryItemInfo) : Boolean
      {
         if(item.getRemainDate() <= 0)
         {
            return false;
         }
         if(item.CategoryID == 11 && item.Property1 == "45")
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CpsAndANchList(item:InventoryItemInfo) : Boolean
      {
         if(item.getRemainDate() <= 0)
         {
            return false;
         }
         if(EquipType.isComposeStone(item) || item.CategoryID == 11 && item.Property1 == "3")
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CpsAndStrthAndformula(item:InventoryItemInfo) : Boolean
      {
         if(item.getRemainDate() <= 0)
         {
            return false;
         }
         if(item.FusionType != 0)
         {
            return true;
         }
         if(EquipType.isComposeStone(item) || item.CategoryID == 11 && item.Property1 == "8" || EquipType.isStrengthStone(item))
         {
            return true;
         }
         if(item.CategoryID == 11 && item.Property1 == "31")
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanRongLiangEquipmengtList(item:InventoryItemInfo) : Boolean
      {
         if(item.FusionType != 0 && item.getRemainDate() > 0 && item.FusionRate > 0)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_canLianhuaEquipList(item:InventoryItemInfo) : Boolean
      {
         if(item.RefineryLevel >= 0 && item.getRemainDate() >= 0)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_canLianhuaPropList(item:InventoryItemInfo) : Boolean
      {
         if(item.getRemainDate() <= 0)
         {
            return false;
         }
         if(item.CategoryID == 11 && (item.Property1 == "32" || item.Property1 == "33") || item.CategoryID == 11 && item.Property1 == "3")
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanTransEquipmengtList(item:InventoryItemInfo) : Boolean
      {
         if(item.CategoryID == 27)
         {
            return false;
         }
         if(item.CategoryID == 70)
         {
            if(item.StrengthenLevel > 1 || item.StrengthenExp > 0)
            {
               return true;
            }
            return false;
         }
         if(item.StrengthenLevel > 0 || item.AttackCompose > 0 || item.DefendCompose > 0 || item.AgilityCompose > 0 || item.LuckCompose > 0 || item.isHasLatentEnergy || item.isCanEnchant() && item.MagicLevel > 0)
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_NotCanTransEquipmengtList(item:InventoryItemInfo) : Boolean
      {
         if(!isProperTo_CanTransEquipmengtList(item))
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanEmbedEquipList(item:InventoryItemInfo) : Boolean
      {
         var propertyArr:* = null;
         if(item.getRemainDate() <= 0 || item.CategoryID == 27)
         {
            return false;
         }
         var holeArr:Array = item.Hole.split("|");
         var _loc6_:int = 0;
         var _loc5_:* = holeArr;
         for each(var hole in holeArr)
         {
            propertyArr = hole.split(",");
            if(propertyArr[1] == "-1")
            {
               return false;
            }
         }
         return true;
      }
      
      private function isProperTo_CanGhostEquipList(item:InventoryItemInfo) : Boolean
      {
         var ghostEquipArr:Array = [1,5,7];
         if(item.Place > 30 || ghostEquipArr.lastIndexOf(item.CategoryID) == -1)
         {
            return false;
         }
         var data:InventoryItemInfo = PlayerManager.Instance.Self.Bag.getItemAt(item.Place);
         return data != null;
      }
      
      private function isProperTo_CanEmbedPropList(item:InventoryItemInfo) : Boolean
      {
         if(item.getRemainDate() <= 0)
         {
            return false;
         }
         if(EquipType.isDrill(item))
         {
            return true;
         }
         if(item.CategoryID == 11 && (item.Property1 == "31" || item.Property1 == "16"))
         {
            return true;
         }
         return false;
      }
      
      private function isProperTo_CanGhostPropList(item:InventoryItemInfo) : Boolean
      {
         if(item.CategoryID == 11 && (item.Property1 == "117" || item.Property1 == "118"))
         {
            return true;
         }
         return false;
      }
      
      private function updateDic(dic:DictionaryData, item:InventoryItemInfo) : void
      {
         var i:int = 0;
         for(i = 0; i < dic.length; )
         {
            if(dic[i] != null && dic[i].Place == item.Place)
            {
               dic.add(i,item);
               dic.dispatchEvent(new UpdateItemEvent("updateItemEvent",i,item));
               return;
            }
            i++;
         }
         addItemToTheFirstNullCell(item,dic);
      }
      
      private function __removeEquip(evt:DictionaryEvent) : void
      {
         var item_1:InventoryItemInfo = evt.data as InventoryItemInfo;
         removeFrom(item_1,_canCpsEquipmentList);
         removeFrom(item_1,_canStrthEqpmtList);
         removeFrom(item_1,_canTransEquipmengtList);
         removeFrom(item_1,_canRongLiangEquipmengtList);
      }
      
      private function addItemToTheFirstNullCell(item:InventoryItemInfo, dic:DictionaryData) : void
      {
         dic.add(findFirstNullCellID(dic),item);
      }
      
      private function findFirstNullCellID(dic:DictionaryData) : int
      {
         var i:int = 0;
         var result:* = -1;
         var lth:int = dic.length;
         for(i = 0; i <= lth; )
         {
            if(dic[i] == null)
            {
               result = i;
               break;
            }
            i++;
         }
         return result;
      }
      
      private function removeFrom(item:InventoryItemInfo, dic:DictionaryData) : void
      {
         var i:int = 0;
         var lth:int = dic.length;
         for(i = 0; i < lth; )
         {
            if(dic[i] && dic[i].Place == item.Place)
            {
               dic[i] = null;
               dic.dispatchEvent(new StoreBagEvent("storeBagRemove",i,item));
               break;
            }
            i++;
         }
      }
      
      public function sortEquipList(equipList:DictionaryData) : DictionaryData
      {
         var temp:* = equipList;
         equipList = new DictionaryData();
         fillByCategoryID(temp,equipList,7);
         fillByCategoryID(temp,equipList,5);
         fillByCategoryID(temp,equipList,1);
         fillByCategoryID(temp,equipList,2);
         fillByCategoryID(temp,equipList,3);
         fillByCategoryID(temp,equipList,4);
         fillByCategoryID(temp,equipList,6);
         fillByCategoryID(temp,equipList,13);
         fillByCategoryID(temp,equipList,15);
         fillByCategoryID(temp,equipList,8);
         fillByCategoryID(temp,equipList,9);
         fillByCategoryID(temp,equipList,17);
         fillByCategoryID(temp,equipList,70);
         equipList = sortByIsUsed(equipList);
         return equipList;
      }
      
      private function sortByIsUsed(source:DictionaryData) : DictionaryData
      {
         var temp:DictionaryData = new DictionaryData();
         var dic:DictionaryData = new DictionaryData();
         var _loc7_:int = 0;
         var _loc6_:* = source;
         for each(var item in source)
         {
            if(item.Place < 17 || item.Place == 18)
            {
               temp.add(temp.length,item);
            }
            else
            {
               dic.add(dic.length,item);
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = dic;
         for each(var itemInfo in dic)
         {
            temp.add(temp.length,itemInfo);
         }
         return temp;
      }
      
      public function sortRoogEquipList(equipList:DictionaryData) : DictionaryData
      {
         var temp:* = equipList;
         equipList = new DictionaryData();
         rongLiangFill(temp,equipList,7);
         rongLiangFill(temp,equipList,17);
         rongLiangFill(temp,equipList,8);
         rongLiangFill(temp,equipList,9);
         rongLiangFill(temp,equipList,14);
         rongLiangFill(temp,equipList,70);
         return equipList;
      }
      
      private function fillByCategoryID(source:DictionaryData, target:DictionaryData, categoryID:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = source;
         for each(var item in source)
         {
            if(item.CategoryID == categoryID)
            {
               target.add(target.length,item);
            }
         }
      }
      
      private function rongLiangFill(source:DictionaryData, target:DictionaryData, CategoryID:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = source;
         for each(var item in source)
         {
            if(item.CategoryID == CategoryID)
            {
               target.add(target.length,item);
            }
         }
      }
      
      private function rongLiangFunFill(source:DictionaryData, target:DictionaryData) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = source;
         for each(var item in source)
         {
            if(item.Property1 == "8")
            {
               target.add(target.length,item);
            }
         }
      }
      
      private function fillByTemplateID(source:DictionaryData, target:DictionaryData, templateID:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = source;
         for each(var item in source)
         {
            if(item.TemplateID == templateID)
            {
               target.add(target.length,item);
            }
         }
      }
      
      private function fillByProperty1AndProperty3(source:DictionaryData, target:DictionaryData, property1:String, property3:String) : void
      {
         var item:* = null;
         var tempArr:Array = [];
         var _loc8_:int = 0;
         var _loc7_:* = source;
         for each(item in source)
         {
            if(item.Property1 == property1 && item.Property3 == property3)
            {
               tempArr.push(item);
            }
         }
         bubbleSort(tempArr);
         var _loc10_:int = 0;
         var _loc9_:* = tempArr;
         for each(item in tempArr)
         {
            target.add(target.length,item);
         }
      }
      
      private function fillByProperty1(source:DictionaryData, target:DictionaryData, property1:String) : void
      {
         var item:* = null;
         var tempArr:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = source;
         for each(item in source)
         {
            if(item.Property1 == property1)
            {
               tempArr.push(item);
            }
         }
         bubbleSort(tempArr);
         var _loc9_:int = 0;
         var _loc8_:* = tempArr;
         for each(item in tempArr)
         {
            target.add(target.length,item);
         }
      }
      
      private function findByTemplateID(source:DictionaryData, target:DictionaryData, templateId:int) : void
      {
         var item:* = null;
         var tempArr:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = source;
         for each(item in source)
         {
            if(item.TemplateID == templateId)
            {
               tempArr.push(item);
            }
         }
         bubbleSort(tempArr);
         var _loc9_:int = 0;
         var _loc8_:* = tempArr;
         for each(item in tempArr)
         {
            target.add(target.length,item);
         }
      }
      
      public function sortOffHandList(propList:DictionaryData) : DictionaryData
      {
         var temp:* = propList;
         propList = new DictionaryData();
         rongLiangFunFill(temp,propList);
         fillOffHand(temp,propList,17);
         return propList;
      }
      
      private function fillOffHand(source:DictionaryData, target:DictionaryData, categoryID:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = source;
         for each(var item in source)
         {
            if(item.CategoryID == categoryID && (item.Property3 == "32" || item.Property3 == "31" || item.Property3 == "132"))
            {
               target.add(target.length,item);
            }
         }
      }
      
      public function sortEvolutionMaterialList(propList:DictionaryData) : DictionaryData
      {
         var temp:* = propList;
         propList = new DictionaryData();
         rongLiangFunFill(temp,propList);
         fillByCategoryID(temp,propList,12572);
         return propList;
      }
      
      public function sortPropList(propList:DictionaryData, isCompose:Boolean = false) : DictionaryData
      {
         var temp:* = propList;
         propList = new DictionaryData();
         rongLiangFunFill(temp,propList);
         fillByProperty1(temp,propList,"2");
         fillByProperty1(temp,propList,"35");
         fillByProperty1(temp,propList,"32");
         fillByProperty1(temp,propList,"33");
         fillByProperty1(temp,propList,"16");
         fillByProperty1(temp,propList,"31");
         fillByProperty1AndProperty3(temp,propList,"1","1");
         fillByProperty1AndProperty3(temp,propList,"1","2");
         fillByProperty1AndProperty3(temp,propList,"1","3");
         fillByProperty1AndProperty3(temp,propList,"1","4");
         if(!isCompose)
         {
            fillByProperty1(temp,propList,"7");
         }
         fillByProperty1(temp,propList,"3");
         rongLiangFill(temp,propList,8);
         rongLiangFill(temp,propList,9);
         rongLiangFill(temp,propList,14);
         fillByProperty1(temp,propList,"10");
         return propList;
      }
      
      public function sortPropStrthList(propList:DictionaryData, isCompose:Boolean = false) : DictionaryData
      {
         var temp:* = propList;
         propList = new DictionaryData();
         rongLiangFunFill(temp,propList);
         fillByProperty1(temp,propList,"2");
         fillByProperty1(temp,propList,"35");
         fillByProperty1(temp,propList,"32");
         fillByProperty1(temp,propList,"33");
         fillByProperty1(temp,propList,"16");
         fillByProperty1(temp,propList,"31");
         fillByProperty1AndProperty3(temp,propList,"1","1");
         fillByProperty1AndProperty3(temp,propList,"1","2");
         fillByProperty1AndProperty3(temp,propList,"1","3");
         fillByProperty1AndProperty3(temp,propList,"1","4");
         rongLiangFill(temp,propList,8);
         rongLiangFill(temp,propList,9);
         rongLiangFill(temp,propList,14);
         fillByProperty1(temp,propList,"10");
         return propList;
      }
      
      private function bubbleSort(dic:Array) : void
      {
         var i:int = 0;
         var flag:Boolean = false;
         var j:int = 0;
         var temp:* = null;
         var lth:int = dic.length;
         for(i = 0; i < lth; )
         {
            flag = true;
            for(j = 0; j < lth - 1; )
            {
               if(dic[j].Quality < dic[j + 1].Quality)
               {
                  temp = dic[j];
                  dic[j] = dic[j + 1];
                  dic[j + 1] = temp;
                  flag = false;
               }
               j++;
            }
            if(flag)
            {
               return;
            }
            i++;
         }
      }
      
      public function get info() : PlayerInfo
      {
         return _info;
      }
      
      public function set currentPanel(currentPanel:int) : void
      {
         _currentPanel = currentPanel;
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
      
      public function set NeedAutoLink(value:int) : void
      {
         _needAutoLink = value;
      }
      
      public function get NeedAutoLink() : int
      {
         return _needAutoLink;
      }
      
      public function checkEmbeded() : Boolean
      {
         var item:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _canEmbedEquipList;
         for(var length in _canEmbedEquipList)
         {
            item = _canEmbedEquipList[int(length)] as InventoryItemInfo;
            if(item && item.Hole1 != -1 && item.Hole1 != 0)
            {
               return false;
            }
            if(item && item.Hole2 != -1 && item.Hole2 != 0)
            {
               return false;
            }
            if(item && item.Hole3 != -1 && item.Hole3 != 0)
            {
               return false;
            }
            if(item && item.Hole4 != -1 && item.Hole4 != 0)
            {
               return false;
            }
            if(item && item.Hole5 != -1 && item.Hole5 != 0)
            {
               return false;
            }
            if(item && item.Hole6 != -1 && item.Hole6 != 0)
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
