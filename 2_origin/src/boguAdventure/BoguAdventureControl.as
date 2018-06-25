package boguAdventure
{
   import boguAdventure.event.BoguAdventureEvent;
   import boguAdventure.model.BoguAdventureCellInfo;
   import boguAdventure.model.BoguAdventureModel;
   import boguAdventure.player.BoguAdventurePlayer;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import road7th.comm.PackageIn;
   
   public class BoguAdventureControl extends EventDispatcher
   {
      
      public static const SIGN_MAX_COUNT:int = 10;
       
      
      public var changeMouse:Boolean;
      
      public var currentIndex:int;
      
      private var _hp:int;
      
      public var isMove:Boolean;
      
      public var signFocus:Point;
      
      public var mineFocus:Point;
      
      public var mineNumFocus:Point;
      
      private var _bogu:BoguAdventurePlayer;
      
      private var _model:BoguAdventureModel;
      
      public function BoguAdventureControl()
      {
         super();
         init();
         SocketManager.Instance.addEventListener("boguadventure",__onAllEvent);
      }
      
      private function init() : void
      {
         _model = new BoguAdventureModel();
         signFocus = new Point(9,39);
         mineFocus = new Point(21,42);
         mineNumFocus = new Point(9,70);
      }
      
      private function __onAllEvent(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var cmd:int = e._cmd;
         switch(int(cmd) - 90)
         {
            case 0:
               enterGame(pkg);
               break;
            case 1:
               updateCell(pkg);
               break;
            case 2:
               revive(pkg);
               break;
            case 3:
               acquireAward(pkg);
               break;
            default:
               acquireAward(pkg);
               break;
            default:
               acquireAward(pkg);
               break;
            default:
               acquireAward(pkg);
               break;
            default:
               acquireAward(pkg);
               break;
            default:
               acquireAward(pkg);
               break;
            case 9:
               _model.resetCount = pkg.readInt();
               _model.isFreeReset = pkg.readBoolean();
               dispatchEvent(new BoguAdventureEvent("boguadventureeventupdatereset"));
         }
      }
      
      private function enterGame(pkg:PackageIn) : void
      {
         var count:int = 0;
         var info:* = null;
         var i:int = 0;
         var tip:* = null;
         var j:int = 0;
         var infoList:Vector.<BoguAdventureCellInfo> = new Vector.<BoguAdventureCellInfo>();
         currentIndex = pkg.readInt();
         hp = pkg.readInt();
         _model.isAcquireAward1 = pkg.readInt() == 1;
         _model.isAcquireAward2 = pkg.readInt() == 1;
         _model.isAcquireAward3 = pkg.readInt() == 1;
         _model.openCount = pkg.readInt();
         _model.findMinePrice = pkg.readInt();
         _model.revivePrice = pkg.readInt();
         _model.resetPrice = pkg.readInt();
         _model.isFreeReset = pkg.readBoolean();
         _model.resetCount = pkg.readInt();
         count = pkg.readInt();
         for(i = 0; i < count; )
         {
            info = new BoguAdventureCellInfo();
            info.index = pkg.readInt();
            info.state = pkg.readInt();
            info.result = pkg.readInt();
            info.aroundMineCount = pkg.readInt();
            infoList.push(info);
            i++;
         }
         _model.mapInfoList = infoList;
         var awardCount:Array = [];
         var awardGoodsTip:Array = [];
         for(i = 0; i < 3; )
         {
            awardCount.push(pkg.readInt());
            count = pkg.readInt();
            tip = "";
            for(j = 0; j < count; )
            {
               tip = tip + (ItemManager.Instance.getTemplateById(pkg.readInt()).Name + "x");
               tip = tip + pkg.readInt().toString();
               tip = tip + "\n";
               j++;
            }
            awardGoodsTip.push(tip);
            i++;
         }
         _model.awardCount = awardCount;
         _model.awardGoodsTip = awardGoodsTip;
         if(_bogu)
         {
            dispatchEvent(new BoguAdventureEvent("boguadventureeventupdatemap"));
         }
      }
      
      private function updateCell(pkg:PackageIn) : void
      {
         var type:int = pkg.readInt();
         var index:int = pkg.readInt();
         var result:int = pkg.readInt();
         _model.findMinePrice = pkg.readInt();
         if(type == 4)
         {
            currentIndex = index;
            hp = pkg.readInt();
            _model.openCount = pkg.readInt();
         }
         dispatchEvent(new BoguAdventureEvent("boguadventureeventupdatecell",{
            "type":type,
            "result":result,
            "index":index
         }));
      }
      
      private function revive(pkg:PackageIn) : void
      {
         hp = pkg.readInt();
      }
      
      private function acquireAward(pkg:PackageIn) : void
      {
         _model.isAcquireAward1 = pkg.readInt() == 1;
         _model.isAcquireAward2 = pkg.readInt() == 1;
         _model.isAcquireAward3 = pkg.readInt() == 1;
      }
      
      public function checkGameOver() : Boolean
      {
         if(_model.openCount >= _model.awardCount[2])
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.gameOver"));
            return true;
         }
         if(_hp <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.hpNotEnough"));
            return true;
         }
         if(!BoguAdventureManager.instance.isOpen)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.activityOver"));
            return true;
         }
         return false;
      }
      
      public function walk(path:Array) : void
      {
         dispatchEvent(new BoguAdventureEvent("boguadventureeventwalk",path));
      }
      
      public function walkComplete() : void
      {
         dispatchEvent(new BoguAdventureEvent("boguadventureeventstop"));
      }
      
      public function playActionComplete(data:Object = null) : void
      {
         dispatchEvent(new BoguAdventureEvent("boguadventureeventactioncomplete",data));
      }
      
      public function get hp() : int
      {
         return _hp;
      }
      
      public function set hp(value:int) : void
      {
         if(_hp == value)
         {
            return;
         }
         _hp = value;
         dispatchEvent(new BoguAdventureEvent("boguadventureeventchangehp"));
      }
      
      public function get bogu() : BoguAdventurePlayer
      {
         return _bogu;
      }
      
      public function set bogu(value:BoguAdventurePlayer) : void
      {
         _bogu = value;
         if(_model.mapInfoList != null)
         {
            dispatchEvent(new BoguAdventureEvent("boguadventureeventupdatemap"));
         }
      }
      
      public function get model() : BoguAdventureModel
      {
         return _model;
      }
      
      public function checkGetAward() : Boolean
      {
         if(_model.openCount >= _model.awardCount[0] && !_model.isAcquireAward1 || _model.openCount >= _model.awardCount[1] && !_model.isAcquireAward2 || _model.openCount >= _model.awardCount[2] && !_model.isAcquireAward3)
         {
            return true;
         }
         return false;
      }
      
      public function dispose() : void
      {
         SocketManager.Instance.removeEventListener("boguadventure",__onAllEvent);
         _bogu = null;
         _model.dispose();
         _model = null;
         signFocus = null;
         mineFocus = null;
         mineNumFocus = null;
      }
   }
}
