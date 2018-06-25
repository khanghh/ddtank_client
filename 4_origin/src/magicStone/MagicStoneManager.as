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
         var event:MagicStoneEvent = new MagicStoneEvent("magicStoneDispose");
         dispatchEvent(event);
      }
      
      public function show() : void
      {
         dispatchEvent(new MagicStoneEvent("magicStoneOpenView"));
      }
      
      public function loadMgStoneTempComplete(analyzer:MagicStoneTempAnalyer) : void
      {
         _mgStoneTempArr = analyzer.mgStoneTempArr;
      }
      
      public function fillPropertys(item:ItemTemplateInfo) : void
      {
         var i:int = 0;
         var vo:* = null;
         for(i = 0; i <= _mgStoneTempArr.length - 1; )
         {
            vo = _mgStoneTempArr[i] as MgStoneTempVO;
            if(vo.TemplateID == item.TemplateID && vo.Level == item.Level)
            {
               item.Attack = vo.Attack;
               item.Defence = vo.Defence;
               item.Agility = vo.Agility;
               item.Luck = vo.Luck;
               item.MagicAttack = vo.MagicAttack;
               item.MagicDefence = vo.MagicDefence;
            }
            i++;
         }
      }
      
      public function getNeedExp(templateId:int, level:int) : int
      {
         var i:int = 0;
         var vo:* = null;
         for(i = 0; i <= _mgStoneTempArr.length - 1; )
         {
            vo = _mgStoneTempArr[i] as MgStoneTempVO;
            if(vo.TemplateID == templateId && vo.Level == level)
            {
               return vo.Exp;
            }
            i++;
         }
         return 0;
      }
      
      public function getNeedExpPerLevel(templateId:int, level:int) : int
      {
         var i:int = 0;
         var vo:* = null;
         var lastExp:int = 0;
         var curExp:int = 0;
         for(i = 0; i <= _mgStoneTempArr.length - 1; )
         {
            vo = _mgStoneTempArr[i] as MgStoneTempVO;
            if(vo.TemplateID == templateId)
            {
               if(vo.Level == level - 1)
               {
                  lastExp = vo.Exp;
               }
               else if(vo.Level == level)
               {
                  curExp = vo.Exp;
               }
            }
            i++;
         }
         return curExp - lastExp > 0?curExp - lastExp:0;
      }
      
      public function getExpOfCurLevel(templateId:int, exp:int) : int
      {
         var i:int = 1;
         var levelExp:int = getNeedExpPerLevel(templateId,i);
         while(levelExp > 0 && exp >= levelExp)
         {
            i++;
            exp = exp - levelExp;
            levelExp = getNeedExpPerLevel(templateId,i);
         }
         return exp;
      }
      
      public function weakGuide(type:int, container:DisplayObjectContainer = null) : void
      {
         if(!container)
         {
            container = LayerManager.Instance.getLayerByType(2);
         }
         switch(int(type))
         {
            case 0:
               if(upTo40Flag && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(117))
               {
                  NewHandContainer.Instance.showArrow(124,0,"hall.mgStoneGuide.openPos","","",container,0,true);
                  MainToolBar.Instance.showBagShineEffect(true);
               }
               break;
            case 1:
               if(upTo40Flag && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(118))
               {
                  NewHandContainer.Instance.showArrow(125,0,"hall.mgStoneGuide.explorePos","magicStone.clickToExplore","hall.mgStoneGuide.exploreTipPos",container,0,true);
               }
               break;
            case 2:
               if(upTo40Flag && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(119))
               {
                  NewHandContainer.Instance.showArrow(126,225,"hall.mgStoneGuide.equipPos","magicStone.doubleClickToEquip","hall.mgStoneGuide.equipTipPos",container,0,true);
               }
               break;
            case 3:
               if(upTo40Flag && !PlayerManager.Instance.Self.isMagicStoneGuideFinish(127))
               {
                  NewHandContainer.Instance.showArrow(138,180,"hall.mgStoneGuide.bagPos","","",container,0,true);
                  break;
               }
         }
      }
      
      public function removeWeakGuide(type:int) : void
      {
         switch(int(type))
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
