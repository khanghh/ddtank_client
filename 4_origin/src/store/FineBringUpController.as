package store
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.Helpers;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import store.fineStore.view.pageBringUp.FineBringUpAlertYESConfirm;
   import trainer.view.NewHandContainer;
   
   public class FineBringUpController extends EventDispatcher
   {
      
      public static const UPDATE_ITEM_LOCK_STATUS:String = "bringup_item_lock_status";
      
      public static const UPDATE_LOCK_STATUS_LIST:String = "bringup_lock_status_list";
      
      public static const EAT_MOUSE_STATUS_CHANGE:String = "eat_mouse_status_change";
      
      protected static const All:String = "all";
      
      protected static const FIRST_ONE:String = "one";
      
      protected static const QUICK:String = "quick";
      
      protected static const ALL_LOW:String = "all_Low";
      
      protected static const ALL_REMAIN:String = "all_remain";
      
      private static var instance:FineBringUpController;
       
      
      private var _hasSetedup:Boolean = false;
      
      public var needUpdate:Boolean = false;
      
      private var _usingLock:Boolean = false;
      
      private var _needPlayMovie:Boolean = false;
      
      private var _container:Sprite;
      
      private var _eatBtnClk:Boolean = false;
      
      private var _state:String = "";
      
      private var _firstConfirm:Boolean = false;
      
      private var __alertLevel:int;
      
      private var _placeMap:Dictionary;
      
      private var _bagBringUpInfo:BagInfo;
      
      private var _tagItem:InventoryItemInfo;
      
      private var _tagTempleteItem:ItemTemplateInfo;
      
      private var _onSending:Boolean;
      
      private var expData:ExpData;
      
      private var _quickEatInfo:InventoryItemInfo;
      
      public function FineBringUpController(single:inner)
      {
         super();
      }
      
      public static function getInstance() : FineBringUpController
      {
         if(!instance)
         {
            instance = new FineBringUpController(new inner());
         }
         return instance;
      }
      
      public function get usingLock() : Boolean
      {
         return _usingLock;
      }
      
      public function set usingLock(value:Boolean) : void
      {
         _usingLock = value;
      }
      
      public function get needPlayMovie() : Boolean
      {
         return _needPlayMovie;
      }
      
      public function dispose() : void
      {
         _placeMap = null;
         _hasSetedup = false;
         _container = null;
         SocketManager.Instance.removeEventListener(PkgEvent.format(308),onBringUpEatResult);
      }
      
      public function setup($container:Sprite) : void
      {
         if(_hasSetedup)
         {
            return;
         }
         _hasSetedup = true;
         _container = $container;
         _onSending = false;
         expData = null;
         _state = "";
         SocketManager.Instance.addEventListener(PkgEvent.format(308),onBringUpEatResult);
      }
      
      protected function onBringUpEatResult(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var isSuccessful:Boolean = pkg.readBoolean();
         if(_state == "all" || _state == "all_remain" || _state == "all_Low")
         {
            eat(_state);
         }
         else
         {
            _onSending = false;
            _needPlayMovie = false;
         }
         dispatchEvent(new CEvent("eat_mouse_status_change","submited"));
      }
      
      public function alertIsMaxLevel() : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.cannotBringUp"),0,false,1);
      }
      
      public function havePropertiesCanNotEaten($item:InventoryItemInfo) : Boolean
      {
         if($item.hasComposeAttribte || $item.MagicLevel > 0 || $item.MagicExp > 0)
         {
            return true;
         }
         return false;
      }
      
      public function alertHavePropertiesCanNotEaten() : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.canNotEatenProperties"),0,true,1);
      }
      
      public function eatBtnClick($info:InventoryItemInfo, $eatenInfo:InventoryItemInfo = null) : void
      {
         _eatBtnClk = true;
         completeNewHandGuide();
         if(havePropertiesCanNotEaten($eatenInfo))
         {
            alertHavePropertiesCanNotEaten();
            dispatchEvent(new CEvent("eat_mouse_status_change","submited"));
            return;
         }
         _tagItem = $info;
         _tagTempleteItem = ItemManager.Instance.getTemplateById($info.TemplateID);
         _quickEatInfo = $eatenInfo;
         if($eatenInfo == null)
         {
            _state = "one";
            eat(_state);
         }
         else
         {
            _state = "quick";
            eat(_state);
         }
      }
      
      public function eatAllBtnClick($info:InventoryItemInfo) : void
      {
         _eatBtnClk = true;
         if(needUpdate)
         {
            needUpdate = false;
            getCanBringUpData();
         }
         completeNewHandGuide();
         _tagItem = $info;
         _tagTempleteItem = ItemManager.Instance.getTemplateById($info.TemplateID);
         _state = "all";
         _firstConfirm = true;
         eat(_state);
      }
      
      public function isMaxLevel($info:InventoryItemInfo) : Boolean
      {
         return $info.FusionType == 0;
      }
      
      private function eat($state:String, $expData:ExpData = null) : void
      {
         $state = $state;
         $expData = $expData;
         _responseEatAll = function(e:FrameEvent):void
         {
            SoundManager.instance.play("008");
            (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseEatAll);
            switch(int(e.responseCode))
            {
               case 0:
               case 1:
                  if(_state == "all" && (level == 2 || level == 4 || level == 6))
                  {
                     if(_state == "all")
                     {
                        _state = "all_Low";
                     }
                     eat(_state);
                  }
                  dispatchEvent(new CEvent("eat_mouse_status_change","canceled"));
                  break;
               case 2:
               case 3:
               case 4:
                  switch(int(level))
                  {
                     case 0:
                        sendEat();
                        break;
                     case 1:
                        sendEat();
                        break;
                     case 2:
                        if((alert as FineBringUpAlertYESConfirm).isYesCorrect())
                        {
                           if($state == "all")
                           {
                              _state = "all_remain";
                           }
                           sendEat();
                           break;
                        }
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.confirmFailed"),0,false,1);
                        break;
                     default:
                     case 4:
                        if((alert as FineBringUpAlertYESConfirm).isYesCorrect())
                        {
                           if($state == "all")
                           {
                              _state = "all_remain";
                           }
                           sendEat();
                           break;
                        }
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.confirmFailed"),0,false,1);
                        break;
                     default:
                     case 6:
                        if((alert as FineBringUpAlertYESConfirm).isYesCorrect())
                        {
                           if($state == "all")
                           {
                              _state = "all_remain";
                           }
                           sendEat();
                           break;
                        }
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.confirmFailed"),0,false,1);
                        break;
                  }
            }
            (e.currentTarget as BaseAlerFrame).dispose();
         };
         onFirstShown = function(e:FrameEvent):void
         {
            SoundManager.instance.play("008");
            (e.currentTarget as BaseAlerFrame).removeEventListener("response",onFirstShown);
            switch(int(e.responseCode) - 1)
            {
               case 0:
                  _onSending = false;
                  expData = null;
                  _state = "";
                  break;
               case 1:
               case 2:
               case 3:
                  eat(_state,expData);
            }
         };
         $expData == null && getExperienceList(_tagItem,$state);
         if(_firstConfirm)
         {
            _firstConfirm = false;
            if(expData.experienceArr.length == 0)
            {
               var msg:String = LanguageMgr.GetTranslation("tank.view.bagII.bringup.noneCanEat");
               MessageTipManager.getInstance().show(msg,0,true,1);
            }
            else
            {
               msg = LanguageMgr.GetTranslation("tank.view.bagII.bringup.eatAll",_tagItem.Name,expData.totalExp);
               var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               alert.addEventListener("response",onFirstShown);
            }
            return;
         }
         var level:int = alertLevel();
         switch(int(level))
         {
            case 0:
               if($state == "all" || $state == "all_Low" || $state == "all_remain")
               {
                  sendEat();
                  return;
               }
               msg = LanguageMgr.GetTranslation("tank.view.bagII.level1EatAll.alert",expData.nameArr[0],expData.experienceArr[0]);
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
               break;
            case 1:
               if($state == "all" || $state == "all_Low" || $state == "all_remain")
               {
                  sendEat();
                  return;
               }
               msg = LanguageMgr.GetTranslation("tank.view.bagII.level1EatAll.alert",expData.nameArr[0],expData.experienceArr[0]);
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("alert"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true);
               break;
            case 2:
               if($state == "all_remain")
               {
                  sendEat();
                  break;
               }
               if($state == "all_Low")
               {
                  return;
               }
               alert = ComponentFactory.Instance.creatComponentByStylename("storeBringUp.confirmYesAlert");
               var aInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("alert"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,msg);
               aInfo.enableHtml = true;
               alert.info = aInfo;
               var experience:int = 0;
               for(var i:int = 0; i < expData.experienceArr.length; )
               {
                  if(expData.experienceArr[i] > experience)
                  {
                     experience = expData.experienceArr[i];
                     var maxExperienceIndex:int = i;
                  }
                  i = Number(i) + 1;
               }
               var itemName:String = "[" + expData.nameArr[maxExperienceIndex] + "]";
               var spaceString:String = Helpers.spaceString(itemName.length * 28,8);
               msg = LanguageMgr.GetTranslation("tank.view.bagII.level2EatAll.alert",spaceString,experience);
               msg = level >= 4?msg + LanguageMgr.GetTranslation("tank.view.bagII.lostMuchExp"):msg;
               (alert as FineBringUpAlertYESConfirm).upadteView(msg,itemName);
               break;
            default:
            case 4:
               if($state == "all_remain")
               {
                  sendEat();
                  break;
               }
               if($state == "all_Low")
               {
                  return;
               }
               alert = ComponentFactory.Instance.creatComponentByStylename("storeBringUp.confirmYesAlert");
               var aInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("alert"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,msg);
               aInfo.enableHtml = true;
               alert.info = aInfo;
               var experience:int = 0;
               for(var i:int = 0; i < expData.experienceArr.length; )
               {
                  if(expData.experienceArr[i] > experience)
                  {
                     experience = expData.experienceArr[i];
                     var maxExperienceIndex:int = i;
                  }
                  i = Number(i) + 1;
               }
               var itemName:String = "[" + expData.nameArr[maxExperienceIndex] + "]";
               var spaceString:String = Helpers.spaceString(itemName.length * 28,8);
               msg = LanguageMgr.GetTranslation("tank.view.bagII.level2EatAll.alert",spaceString,experience);
               msg = level >= 4?msg + LanguageMgr.GetTranslation("tank.view.bagII.lostMuchExp"):msg;
               (alert as FineBringUpAlertYESConfirm).upadteView(msg,itemName);
               break;
            default:
            case 6:
               if($state == "all_remain")
               {
                  sendEat();
                  break;
               }
               if($state == "all_Low")
               {
                  return;
               }
               alert = ComponentFactory.Instance.creatComponentByStylename("storeBringUp.confirmYesAlert");
               var aInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("alert"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,msg);
               aInfo.enableHtml = true;
               alert.info = aInfo;
               var experience:int = 0;
               for(var i:int = 0; i < expData.experienceArr.length; )
               {
                  if(expData.experienceArr[i] > experience)
                  {
                     experience = expData.experienceArr[i];
                     var maxExperienceIndex:int = i;
                  }
                  i = Number(i) + 1;
               }
               var itemName:String = "[" + expData.nameArr[maxExperienceIndex] + "]";
               var spaceString:String = Helpers.spaceString(itemName.length * 28,8);
               msg = LanguageMgr.GetTranslation("tank.view.bagII.level2EatAll.alert",spaceString,experience);
               msg = level >= 4?msg + LanguageMgr.GetTranslation("tank.view.bagII.lostMuchExp"):msg;
               (alert as FineBringUpAlertYESConfirm).upadteView(msg,itemName);
               break;
         }
         if(alert.parent == null)
         {
            LayerManager.Instance.addToLayer(alert,0,true,2);
         }
         alert.addEventListener("response",_responseEatAll);
      }
      
      private function sendEat() : void
      {
         var args:* = null;
         var len:int = 0;
         var i:int = 0;
         _needPlayMovie = true;
         _onSending = true;
         if(expData != null && expData.placeArr.length > 0)
         {
            args = [];
            len = expData.placeArr.length;
            for(i = 0; i < len; )
            {
               args.push(0);
               args.push(expData.placeArr.shift());
               expData.experienceArr.shift();
               expData.nameArr.shift();
               i++;
            }
            GameInSocketOut.sendBringUpEat(len,args);
         }
         if(!expData || expData.placeArr.length <= 0)
         {
            _onSending = false;
            expData = null;
            _state = "";
         }
      }
      
      public function buyExp($type:int, $num:int) : void
      {
         _onSending = false;
         expData = null;
         _state = "";
         GameInSocketOut.sendBringUpEat(0,$type,$num);
      }
      
      private function alertLevel() : int
      {
         var item:* = null;
         var i:int = 0;
         __alertLevel = 0;
         var list:Array = _bagBringUpInfo.items.list;
         var len:int = list.length;
         if(_state == "quick")
         {
            item = ItemManager.Instance.getTemplateById(_quickEatInfo.TemplateID);
            __alertLevel = checkLevel(item);
         }
         else
         {
            for(i = 0; i < len; )
            {
               if((list[i] as InventoryItemInfo).cellLocked != true)
               {
                  if(!havePropertiesCanNotEaten(list[i]))
                  {
                     item = ItemManager.Instance.getTemplateById((list[i] as InventoryItemInfo).TemplateID);
                     __alertLevel = checkLevel(item);
                     if(!(_state == "all" && __alertLevel == 0 || _state == "all_Low" && __alertLevel > 1))
                     {
                        break;
                     }
                  }
               }
               i++;
            }
         }
         return __alertLevel;
      }
      
      private function checkLevel($item:ItemTemplateInfo) : int
      {
         var __level:* = 0;
         if(int($item.Property1) >= 4)
         {
            __level = 2 | __level;
         }
         if(int($item.Property3) > int(_tagTempleteItem.Property3) && int($item.Property1) >= 2)
         {
            __level = 4 | __level;
         }
         return __level;
      }
      
      private function getExperienceList(tagItem:InventoryItemInfo, type:String) : ExpData
      {
         tagItem = tagItem;
         type = type;
         search = function():void
         {
            var i:int = 0;
            var item:* = null;
            var expCanEat:Number = NaN;
            var list:Array = _bagBringUpInfo.items.list;
            list.sortOn("Place",16);
            var len:int = list.length;
            for(i = 0; i < len; )
            {
               item = list[i] as InventoryItemInfo;
               if(item.cellLocked == false && item.getRemainDate() > 0 && tagItem.Place != item.Place)
               {
                  if(!havePropertiesCanNotEaten(item))
                  {
                     if(!(_state == "all_Low" && checkLevel(item) > 1))
                     {
                        expCanEat = calculateExperience(tagItemTempleteID,item);
                        obj.totalExp = obj.totalExp + expCanEat;
                        obj.experienceArr.push(expCanEat);
                        obj.placeArr.push(item.Place);
                        obj.nameArr.push(item.Name);
                        if(!isAll)
                        {
                           break;
                        }
                     }
                  }
               }
               i++;
            }
         };
         var obj:ExpData = new ExpData();
         var tagItemTempleteID:int = tagItem.TemplateID;
         if(type == "quick")
         {
            obj.totalExp = calculateExperience(tagItemTempleteID,_quickEatInfo);
            obj.experienceArr.push(obj.totalExp);
            obj.nameArr.push(_quickEatInfo.Name);
            obj.placeArr.push(_quickEatInfo.Place);
            return obj;
         }
         var isAll:Boolean = type == "all" || type == "all_Low" || type == "all_remain";
         search();
         return obj;
      }
      
      private function calculateExperience(tagItemTempleteID:int, beEatenItem:InventoryItemInfo) : Number
      {
         var exp:* = 0;
         var tagTempleteInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(tagItemTempleteID);
         var beEatenTempleteInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(beEatenItem.TemplateID);
         var tagLevel:int = tagTempleteInfo.Property1;
         var tagQuality:int = tagTempleteInfo.Property3;
         var eatenLevel:int = beEatenTempleteInfo.Property1;
         var eatenOrigExp:int = beEatenTempleteInfo.Property2;
         var eatenQuality:* = int(beEatenTempleteInfo.Property3);
         var eatenCurExp:* = int(beEatenItem.curExp);
         if(tagQuality < eatenQuality)
         {
            beEatenTempleteInfo = getTempleteInfoByLevel(eatenLevel,tagTempleteInfo);
            eatenLevel;
            eatenOrigExp = beEatenTempleteInfo.Property2;
            eatenQuality = tagQuality;
            eatenCurExp = eatenOrigExp;
         }
         if(eatenCurExp == 0)
         {
            eatenCurExp = eatenOrigExp;
         }
         exp = Number(eatenCurExp);
         return exp;
      }
      
      private function getTempleteInfoByLevel(eatenLevel:int, tagItemInfo:ItemTemplateInfo) : ItemTemplateInfo
      {
         var curLevel:int = tagItemInfo.Property1;
         if(curLevel > eatenLevel)
         {
            while(curLevel > eatenLevel)
            {
               if(int(tagItemInfo.Property4) != 0)
               {
                  tagItemInfo = ItemManager.Instance.getTemplateById(int(tagItemInfo.Property4));
                  curLevel = tagItemInfo.Property1;
                  continue;
               }
               break;
            }
         }
         else if(curLevel < eatenLevel)
         {
            while(curLevel < eatenLevel)
            {
               if(tagItemInfo.FusionType != 0)
               {
                  tagItemInfo = ItemManager.Instance.getTemplateById(tagItemInfo.FusionType);
                  curLevel = tagItemInfo.Property1;
                  continue;
               }
               break;
            }
         }
         return tagItemInfo;
      }
      
      public function getPlaceMap() : Dictionary
      {
         if(_placeMap != null)
         {
            return _placeMap;
         }
         getCanBringUpData();
         _placeMap = new Dictionary();
         var cellPlace:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _bagBringUpInfo.items;
         for each(var value in _bagBringUpInfo.items)
         {
            if(value.Place <= 15)
            {
               value.cellLocked = true;
               GameInSocketOut.sendBringUpLockStatusUpdate(value.BagType,value.Place,true);
            }
            _placeMap[cellPlace] = value.Place;
            cellPlace++;
         }
         return _placeMap;
      }
      
      public function getItem(itemPlace:int) : InventoryItemInfo
      {
         var itms:DictionaryData = _bagBringUpInfo.items;
         var _loc5_:int = 0;
         var _loc4_:* = itms;
         for each(var v in itms)
         {
            if(v.Place == itemPlace)
            {
               return v;
            }
         }
         return null;
      }
      
      public function getCanBringUpData() : BagInfo
      {
         isNotWeddingRing = function(item:InventoryItemInfo):Boolean
         {
            var _loc2_:* = item.TemplateID;
            if(9022 !== _loc2_)
            {
               if(9122 !== _loc2_)
               {
                  if(9222 !== _loc2_)
                  {
                     if(9322 !== _loc2_)
                     {
                        if(9422 !== _loc2_)
                        {
                           if(9522 !== _loc2_)
                           {
                              return true;
                           }
                        }
                        addr13:
                        return false;
                     }
                     addr12:
                     §§goto(addr13);
                  }
                  addr11:
                  §§goto(addr12);
               }
               addr10:
               §§goto(addr11);
            }
            §§goto(addr10);
         };
         var bagList:DictionaryData = PlayerManager.Instance.Self.Bag.items;
         _bagBringUpInfo = new BagInfo(0,21);
         var _loc3_:int = 0;
         var _loc2_:* = bagList;
         for each(item in bagList)
         {
            if((item.CategoryID == 8 || item.CategoryID == 9) && isNotWeddingRing(item) && item.getRemainDate() > 0)
            {
               var __item:InventoryItemInfo = new InventoryItemInfo();
               ObjectUtils.copyProperties(__item,item);
               _bagBringUpInfo.addItem(__item);
            }
         }
         return _bagBringUpInfo;
      }
      
      public function isTopLevel() : void
      {
         if(_eatBtnClk)
         {
            _eatBtnClk = false;
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.isTopLevel"));
      }
      
      public function isExpJewelry() : void
      {
         if(_eatBtnClk)
         {
            _eatBtnClk = false;
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.isExpJewelry"));
      }
      
      public function showNewHandTip() : void
      {
         if(needGuide())
         {
            if(_container != null)
            {
               NewHandContainer.Instance.showArrow(144,135,new Point(383,443),"asset.trainer.bringupAsset","guide.bringup.btnPos",_container,0,true);
            }
         }
      }
      
      public function hideNewHandTip() : void
      {
         NewHandContainer.Instance.clearArrowByID(144);
      }
      
      public function completeNewHandGuide() : void
      {
         NewHandContainer.Instance.clearArrowByID(144);
         SocketManager.Instance.out.syncWeakStep(101);
      }
      
      public function progress($info:InventoryItemInfo) : int
      {
         var totalProgress:Number = NaN;
         var curProress:Number = NaN;
         if($info == null)
         {
            return 0;
         }
         var next:int = ItemManager.Instance.getTemplateById($info.TemplateID).FusionType;
         if(next == 0)
         {
            return 0;
         }
         totalProgress = int(ItemManager.Instance.getTemplateById(next).Property2);
         curProress = int($info.curExp);
         return curProress / totalProgress * 100;
      }
      
      public function expDataArr($info:ItemTemplateInfo) : Array
      {
         var _exp:int = 0;
         var _UpExp:int = 0;
         if($info == null)
         {
            return [0,0];
         }
         if(($info as InventoryItemInfo).curExp == 0)
         {
            _exp = ItemManager.Instance.getTemplateById($info.TemplateID).Property2;
         }
         else
         {
            _exp = ($info as InventoryItemInfo).curExp;
         }
         if($info.FusionType == 0)
         {
            _UpExp = 0;
         }
         else
         {
            _UpExp = ItemManager.Instance.getTemplateById($info.FusionType).Property2;
         }
         return [_exp,_UpExp];
      }
      
      public function progressTipData($info:ItemTemplateInfo) : String
      {
         var arr:Array = expDataArr($info);
         return arr[0].toString() + "/" + arr[1].toString();
      }
      
      public function needGuide() : Boolean
      {
         return PlayerManager.Instance.Self.IsWeakGuildFinish(101);
      }
      
      public function get onSending() : Boolean
      {
         return _onSending;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}

class ExpData
{
    
   
   public var totalExp:Number = 0;
   
   public var placeArr:Array;
   
   public var experienceArr:Array;
   
   public var nameArr:Array;
   
   function ExpData()
   {
      placeArr = [];
      experienceArr = [];
      nameArr = [];
      super();
   }
}
