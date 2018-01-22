package magicStone
{
   import com.pickgliss.ui.LayerManager;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.view.MainToolBar;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import magicStone.data.MagicStoneTempAnalyer;
   import magicStone.data.MgStoneTempVO;
   import magicStone.event.MagicStoneEvent;
   import trainer.view.NewHandContainer;
   
   public class MagicStoneManager extends EventDispatcher
   {
      
      private static var _instance:MagicStoneManager;
       
      
      private var _mgStoneTempArr:Array;
      
      private var _upgradeMC:MovieClip;
      
      public var upTo40Flag:Boolean = false;
      
      public function MagicStoneManager()
      {
         super();
      }
      
      public static function get instance() : MagicStoneManager
      {
         if(!_instance)
         {
            _instance = new MagicStoneManager();
         }
         return _instance;
      }
      
      public function disposeView() : void
      {
         var _loc1_:MagicStoneEvent = new MagicStoneEvent("magicStoneDispose");
         dispatchEvent(_loc1_);
      }
      
      public function show() : void
      {
         dispatchEvent(new MagicStoneEvent("magicStoneOpenView"));
      }
      
      public function loadMgStoneTempComplete(param1:MagicStoneTempAnalyer) : void
      {
         _mgStoneTempArr = param1.mgStoneTempArr;
      }
      
      public function fillPropertys(param1:ItemTemplateInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ <= _mgStoneTempArr.length - 1)
         {
            _loc2_ = _mgStoneTempArr[_loc3_] as MgStoneTempVO;
            if(_loc2_.TemplateID == param1.TemplateID && _loc2_.Level == param1.Level)
            {
               param1.Attack = _loc2_.Attack;
               param1.Defence = _loc2_.Defence;
               param1.Agility = _loc2_.Agility;
               param1.Luck = _loc2_.Luck;
               param1.MagicAttack = _loc2_.MagicAttack;
               param1.MagicDefence = _loc2_.MagicDefence;
            }
            _loc3_++;
         }
      }
      
      public function getNeedExp(param1:int, param2:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _loc4_ = 0;
         while(_loc4_ <= _mgStoneTempArr.length - 1)
         {
            _loc3_ = _mgStoneTempArr[_loc4_] as MgStoneTempVO;
            if(_loc3_.TemplateID == param1 && _loc3_.Level == param2)
            {
               return _loc3_.Exp;
            }
            _loc4_++;
         }
         return 0;
      }
      
      public function getNeedExpPerLevel(param1:int, param2:int) : int
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc6_ = 0;
         while(_loc6_ <= _mgStoneTempArr.length - 1)
         {
            _loc5_ = _mgStoneTempArr[_loc6_] as MgStoneTempVO;
            if(_loc5_.TemplateID == param1)
            {
               if(_loc5_.Level == param2 - 1)
               {
                  _loc3_ = _loc5_.Exp;
               }
               else if(_loc5_.Level == param2)
               {
                  _loc4_ = _loc5_.Exp;
               }
            }
            _loc6_++;
         }
         return _loc4_ - _loc3_ > 0?_loc4_ - _loc3_:0;
      }
      
      public function getExpOfCurLevel(param1:int, param2:int) : int
      {
         var _loc4_:int = 1;
         var _loc3_:int = getNeedExpPerLevel(param1,_loc4_);
         while(_loc3_ > 0 && param2 >= _loc3_)
         {
            _loc4_++;
            param2 = param2 - _loc3_;
            _loc3_ = getNeedExpPerLevel(param1,_loc4_);
         }
         return param2;
      }
      
      public function weakGuide(param1:int, param2:DisplayObjectContainer = null) : void
      {
         if(!param2)
         {
            param2 = LayerManager.Instance.getLayerByType(2);
         }
         switch(int(param1))
         {
            case 0:
               if(upTo40Flag && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(117))
               {
                  NewHandContainer.Instance.showArrow(124,0,"hall.mgStoneGuide.openPos","","",param2,0,true);
                  MainToolBar.Instance.showBagShineEffect(true);
               }
               break;
            case 1:
               if(upTo40Flag && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(118))
               {
                  NewHandContainer.Instance.showArrow(125,0,"hall.mgStoneGuide.explorePos","magicStone.clickToExplore","hall.mgStoneGuide.exploreTipPos",param2,0,true);
               }
               break;
            case 2:
               if(upTo40Flag && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(119))
               {
                  NewHandContainer.Instance.showArrow(126,225,"hall.mgStoneGuide.equipPos","magicStone.doubleClickToEquip","hall.mgStoneGuide.equipTipPos",param2,0,true);
               }
               break;
            case 3:
               if(upTo40Flag && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(127))
               {
                  NewHandContainer.Instance.showArrow(138,180,"hall.mgStoneGuide.bagPos","","",param2,0,true);
                  break;
               }
         }
      }
      
      public function removeWeakGuide(param1:int) : void
      {
         switch(int(param1))
         {
            case 0:
               if(PlayerManager.Instance.Self.Grade >= 45 && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(117))
               {
                  SocketManager.Instance.out.syncWeakStep(117);
                  NewHandContainer.Instance.clearArrowByID(124);
                  MainToolBar.Instance.showBagShineEffect(false);
               }
               break;
            case 1:
               if(PlayerManager.Instance.Self.Grade >= 45 && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(118))
               {
                  SocketManager.Instance.out.syncWeakStep(118);
                  NewHandContainer.Instance.clearArrowByID(125);
               }
               break;
            case 2:
               if(PlayerManager.Instance.Self.Grade >= 45 && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(119))
               {
                  SocketManager.Instance.out.syncWeakStep(119);
                  NewHandContainer.Instance.clearArrowByID(126);
               }
               break;
            case 3:
               if(PlayerManager.Instance.Self.Grade >= 45 && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(127))
               {
                  SocketManager.Instance.out.syncWeakStep(127);
                  NewHandContainer.Instance.clearArrowByID(138);
                  break;
               }
         }
      }
   }
}
