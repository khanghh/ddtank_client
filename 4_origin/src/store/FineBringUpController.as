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
      
      public function FineBringUpController(param1:inner)
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
      
      public function set usingLock(param1:Boolean) : void
      {
         _usingLock = param1;
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
      
      public function setup(param1:Sprite) : void
      {
         if(_hasSetedup)
         {
            return;
         }
         _hasSetedup = true;
         _container = param1;
         _onSending = false;
         expData = null;
         _state = "";
         SocketManager.Instance.addEventListener(PkgEvent.format(308),onBringUpEatResult);
      }
      
      protected function onBringUpEatResult(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
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
      
      public function havePropertiesCanNotEaten(param1:InventoryItemInfo) : Boolean
      {
         if(param1.hasComposeAttribte || param1.MagicLevel > 0 || param1.MagicExp > 0)
         {
            return true;
         }
         return false;
      }
      
      public function alertHavePropertiesCanNotEaten() : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.bagII.bringup.canNotEatenProperties"),0,true,1);
      }
      
      public function eatBtnClick(param1:InventoryItemInfo, param2:InventoryItemInfo = null) : void
      {
         _eatBtnClk = true;
         completeNewHandGuide();
         if(havePropertiesCanNotEaten(param2))
         {
            alertHavePropertiesCanNotEaten();
            dispatchEvent(new CEvent("eat_mouse_status_change","submited"));
            return;
         }
         _tagItem = param1;
         _tagTempleteItem = ItemManager.Instance.getTemplateById(param1.TemplateID);
         _quickEatInfo = param2;
         if(param2 == null)
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
      
      public function eatAllBtnClick(param1:InventoryItemInfo) : void
      {
         _eatBtnClk = true;
         if(needUpdate)
         {
            needUpdate = false;
            getCanBringUpData();
         }
         completeNewHandGuide();
         _tagItem = param1;
         _tagTempleteItem = ItemManager.Instance.getTemplateById(param1.TemplateID);
         _state = "all";
         _firstConfirm = true;
         eat(_state);
      }
      
      public function isMaxLevel(param1:InventoryItemInfo) : Boolean
      {
         return param1.FusionType == 0;
      }
      
      private function eat(param1:String, param2:ExpData = null) : void
      {
         $state = param1;
         $expData = param2;
         _responseEatAll = function(param1:FrameEvent):void
         {
            SoundManager.instance.play("008");
            (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseEatAll);
            switch(int(param1.responseCode))
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
            (param1.currentTarget as BaseAlerFrame).dispose();
         };
         onFirstShown = function(param1:FrameEvent):void
         {
            SoundManager.instance.play("008");
            (param1.currentTarget as BaseAlerFrame).removeEventListener("response",onFirstShown);
            switch(int(param1.responseCode) - 1)
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
               var i:int = 0;
               while(i < expData.experienceArr.length)
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
               var i:int = 0;
               while(i < expData.experienceArr.length)
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
               var i:int = 0;
               while(i < expData.experienceArr.length)
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
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _needPlayMovie = true;
         _onSending = true;
         if(expData != null && expData.placeArr.length > 0)
         {
            _loc1_ = [];
            _loc2_ = expData.placeArr.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_.push(0);
               _loc1_.push(expData.placeArr.shift());
               expData.experienceArr.shift();
               expData.nameArr.shift();
               _loc3_++;
            }
            GameInSocketOut.sendBringUpEat(_loc2_,_loc1_);
         }
         if(!expData || expData.placeArr.length <= 0)
         {
            _onSending = false;
            expData = null;
            _state = "";
         }
      }
      
      public function buyExp(param1:int, param2:int) : void
      {
         _onSending = false;
         expData = null;
         _state = "";
         GameInSocketOut.sendBringUpEat(0,param1,param2);
      }
      
      private function alertLevel() : int
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         __alertLevel = 0;
         var _loc2_:Array = _bagBringUpInfo.items.list;
         var _loc3_:int = _loc2_.length;
         if(_state == "quick")
         {
            _loc1_ = ItemManager.Instance.getTemplateById(_quickEatInfo.TemplateID);
            __alertLevel = checkLevel(_loc1_);
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if((_loc2_[_loc4_] as InventoryItemInfo).cellLocked != true)
               {
                  if(!havePropertiesCanNotEaten(_loc2_[_loc4_]))
                  {
                     _loc1_ = ItemManager.Instance.getTemplateById((_loc2_[_loc4_] as InventoryItemInfo).TemplateID);
                     __alertLevel = checkLevel(_loc1_);
                     if(!(_state == "all" && __alertLevel == 0 || _state == "all_Low" && __alertLevel > 1))
                     {
                        break;
                     }
                  }
               }
               _loc4_++;
            }
         }
         return __alertLevel;
      }
      
      private function checkLevel(param1:ItemTemplateInfo) : int
      {
         var _loc2_:* = 0;
         if(int(param1.Property1) >= 4)
         {
            _loc2_ = 2 | _loc2_;
         }
         if(int(param1.Property3) > int(_tagTempleteItem.Property3) && int(param1.Property1) >= 2)
         {
            _loc2_ = 4 | _loc2_;
         }
         return _loc2_;
      }
      
      private function getExperienceList(param1:InventoryItemInfo, param2:String) : ExpData
      {
         tagItem = param1;
         type = param2;
         search = function():void
         {
            var _loc5_:int = 0;
            var _loc1_:* = null;
            var _loc2_:Number = NaN;
            var _loc3_:Array = _bagBringUpInfo.items.list;
            _loc3_.sortOn("Place",16);
            var _loc4_:int = _loc3_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc1_ = _loc3_[_loc5_] as InventoryItemInfo;
               if(_loc1_.cellLocked == false && _loc1_.getRemainDate() > 0 && tagItem.Place != _loc1_.Place)
               {
                  if(!havePropertiesCanNotEaten(_loc1_))
                  {
                     if(!(_state == "all_Low" && checkLevel(_loc1_) > 1))
                     {
                        _loc2_ = calculateExperience(tagItemTempleteID,_loc1_);
                        obj.totalExp = obj.totalExp + _loc2_;
                        obj.experienceArr.push(_loc2_);
                        obj.placeArr.push(_loc1_.Place);
                        obj.nameArr.push(_loc1_.Name);
                        if(!isAll)
                        {
                           break;
                        }
                     }
                  }
               }
               _loc5_++;
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
      
      private function calculateExperience(param1:int, param2:InventoryItemInfo) : Number
      {
         var _loc5_:* = 0;
         var _loc7_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1);
         var _loc8_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param2.TemplateID);
         var _loc11_:int = _loc7_.Property1;
         var _loc10_:int = _loc7_.Property3;
         var _loc9_:int = _loc8_.Property1;
         var _loc4_:int = _loc8_.Property2;
         var _loc3_:* = int(_loc8_.Property3);
         var _loc6_:* = int(param2.curExp);
         if(_loc10_ < _loc3_)
         {
            _loc8_ = getTempleteInfoByLevel(_loc9_,_loc7_);
            _loc9_;
            _loc4_ = _loc8_.Property2;
            _loc3_ = _loc10_;
            _loc6_ = _loc4_;
         }
         if(_loc6_ == 0)
         {
            _loc6_ = _loc4_;
         }
         _loc5_ = Number(_loc6_);
         return _loc5_;
      }
      
      private function getTempleteInfoByLevel(param1:int, param2:ItemTemplateInfo) : ItemTemplateInfo
      {
         var _loc3_:int = param2.Property1;
         if(_loc3_ > param1)
         {
            while(_loc3_ > param1)
            {
               if(int(param2.Property4) != 0)
               {
                  param2 = ItemManager.Instance.getTemplateById(int(param2.Property4));
                  _loc3_ = param2.Property1;
                  continue;
               }
               break;
            }
         }
         else if(_loc3_ < param1)
         {
            while(_loc3_ < param1)
            {
               if(param2.FusionType != 0)
               {
                  param2 = ItemManager.Instance.getTemplateById(param2.FusionType);
                  _loc3_ = param2.Property1;
                  continue;
               }
               break;
            }
         }
         return param2;
      }
      
      public function getPlaceMap() : Dictionary
      {
         if(_placeMap != null)
         {
            return _placeMap;
         }
         getCanBringUpData();
         _placeMap = new Dictionary();
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _bagBringUpInfo.items;
         for each(var _loc1_ in _bagBringUpInfo.items)
         {
            if(_loc1_.Place <= 15)
            {
               _loc1_.cellLocked = true;
               GameInSocketOut.sendBringUpLockStatusUpdate(_loc1_.BagType,_loc1_.Place,true);
            }
            _placeMap[_loc2_] = _loc1_.Place;
            _loc2_++;
         }
         return _placeMap;
      }
      
      public function getItem(param1:int) : InventoryItemInfo
      {
         var _loc3_:DictionaryData = _bagBringUpInfo.items;
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            if(_loc2_.Place == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getCanBringUpData() : BagInfo
      {
         isNotWeddingRing = function(param1:InventoryItemInfo):Boolean
         {
            var _loc2_:* = param1.TemplateID;
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
                        addr9:
                        return false;
                     }
                     addr8:
                     §§goto(addr9);
                  }
                  addr7:
                  §§goto(addr8);
               }
               addr6:
               §§goto(addr7);
            }
            §§goto(addr6);
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
      
      public function progress(param1:InventoryItemInfo) : int
      {
         var _loc2_:Number = NaN;
         var _loc4_:Number = NaN;
         if(param1 == null)
         {
            return 0;
         }
         var _loc3_:int = ItemManager.Instance.getTemplateById(param1.TemplateID).FusionType;
         if(_loc3_ == 0)
         {
            return 0;
         }
         _loc2_ = int(ItemManager.Instance.getTemplateById(_loc3_).Property2);
         _loc4_ = int(param1.curExp);
         return _loc4_ / _loc2_ * 100;
      }
      
      public function expDataArr(param1:ItemTemplateInfo) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return [0,0];
         }
         if((param1 as InventoryItemInfo).curExp == 0)
         {
            _loc3_ = ItemManager.Instance.getTemplateById(param1.TemplateID).Property2;
         }
         else
         {
            _loc3_ = (param1 as InventoryItemInfo).curExp;
         }
         if(param1.FusionType == 0)
         {
            _loc2_ = 0;
         }
         else
         {
            _loc2_ = ItemManager.Instance.getTemplateById(param1.FusionType).Property2;
         }
         return [_loc3_,_loc2_];
      }
      
      public function progressTipData(param1:ItemTemplateInfo) : String
      {
         var _loc2_:Array = expDataArr(param1);
         return _loc2_[0].toString() + "/" + _loc2_[1].toString();
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
