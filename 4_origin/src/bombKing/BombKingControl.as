package bombKing
{
   import bombKing.components.BKingPrizeTip;
   import bombKing.event.BombKingEvent;
   import bombKing.view.BombKingMainFrame;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.analyze.FightReportAnalyze;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.QueueManager;
   import ddt.manager.SocketManager;
   import ddt.utils.RequestVairableCreater;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.URLVariables;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   
   public class BombKingControl
   {
      
      private static var _instance:BombKingControl;
       
      
      private var _frameSprite:Sprite;
      
      private var _frame:BombKingMainFrame;
      
      private var _cmdID:int = 0;
      
      private var _cmdVec:Vector.<int>;
      
      private var _pkgVec:Vector.<PackageIn>;
      
      private var _showMsg:Boolean = true;
      
      private var _startGameId:int = 0;
      
      public var ReportID:String;
      
      public var isOpen:Boolean;
      
      public var status:int;
      
      public function BombKingControl()
      {
         super();
         _frameSprite = new Sprite();
         _cmdVec = new Vector.<int>();
      }
      
      public static function get instance() : BombKingControl
      {
         if(!_instance)
         {
            _instance = new BombKingControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
         SocketManager.Instance.out.getBKingStatueInfo();
         SocketManager.Instance.out.requestBKingShowTip();
      }
      
      private function initEvent() : void
      {
         RoomManager.Instance.addEventListener("startloadbattlexml",__onStartLoadBattleXml);
         SocketManager.Instance.addEventListener(PkgEvent.format(263,9),__showTip);
         BombKingManager.instance.addEventListener("bombkingOpenView",__onOpenView);
      }
      
      protected function __onStartLoadBattleXml(event:BombKingEvent) : void
      {
         var loader:BaseLoader = getFightReportLoader(ReportID);
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      protected function __showTip(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         isOpen = pkg.readBoolean();
         if(isOpen && _showMsg)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("bombKing.battling"));
         }
         _showMsg = false;
         if(_frame)
         {
            _frame.setDateOfNext();
         }
      }
      
      protected function __onEnterFrame(evt:Event) : void
      {
         var event:CrazyTankSocketEvent = null;
         if(_cmdID < _cmdVec.length)
         {
            event = creatGameEvent(_cmdID);
            if(event)
            {
               QueueManager.addQueue(event);
               _cmdID = Number(_cmdID) + 1;
            }
         }
         else
         {
            reset();
         }
      }
      
      private function creatGameEvent(id:int) : CrazyTankSocketEvent
      {
         var event:CrazyTankSocketEvent = null;
         var _loc3_:* = _cmdVec[id];
         if(129 !== _loc3_)
         {
            if(128 !== _loc3_)
            {
               if(116 !== _loc3_)
               {
                  if(66 !== _loc3_)
                  {
                     if(65 !== _loc3_)
                     {
                        if(104 !== _loc3_)
                        {
                           if(101 !== _loc3_)
                           {
                              if(99 !== _loc3_)
                              {
                                 if(97 !== _loc3_)
                                 {
                                    if(103 !== _loc3_)
                                    {
                                       if(113 !== _loc3_)
                                       {
                                          if(100 !== _loc3_)
                                          {
                                             if(112 !== _loc3_)
                                             {
                                                if(115 !== _loc3_)
                                                {
                                                   if(7 !== _loc3_)
                                                   {
                                                      if(8 !== _loc3_)
                                                      {
                                                         if(2 !== _loc3_)
                                                         {
                                                            if(131 !== _loc3_)
                                                            {
                                                               if(9 !== _loc3_)
                                                               {
                                                                  if(10 !== _loc3_)
                                                                  {
                                                                     if(6 !== _loc3_)
                                                                     {
                                                                        if(11 !== _loc3_)
                                                                        {
                                                                           if(33 !== _loc3_)
                                                                           {
                                                                              if(82 !== _loc3_)
                                                                              {
                                                                                 if(118 !== _loc3_)
                                                                                 {
                                                                                    if(41 !== _loc3_)
                                                                                    {
                                                                                       if(34 !== _loc3_)
                                                                                       {
                                                                                          if(38 !== _loc3_)
                                                                                          {
                                                                                             if(35 !== _loc3_)
                                                                                             {
                                                                                                if(36 !== _loc3_)
                                                                                                {
                                                                                                   if(37 !== _loc3_)
                                                                                                   {
                                                                                                      if(52 !== _loc3_)
                                                                                                      {
                                                                                                         if(15 !== _loc3_)
                                                                                                         {
                                                                                                            if(32 !== _loc3_)
                                                                                                            {
                                                                                                               if(14 !== _loc3_)
                                                                                                               {
                                                                                                                  if(242 !== _loc3_)
                                                                                                                  {
                                                                                                                     if(16 !== _loc3_)
                                                                                                                     {
                                                                                                                        if(46 !== _loc3_)
                                                                                                                        {
                                                                                                                           if(47 !== _loc3_)
                                                                                                                           {
                                                                                                                              if(44 !== _loc3_)
                                                                                                                              {
                                                                                                                                 if(17 !== _loc3_)
                                                                                                                                 {
                                                                                                                                    if(96 !== _loc3_)
                                                                                                                                    {
                                                                                                                                       if(20 !== _loc3_)
                                                                                                                                       {
                                                                                                                                          if(49 !== _loc3_)
                                                                                                                                          {
                                                                                                                                             if(3 !== _loc3_)
                                                                                                                                             {
                                                                                                                                                if(22 !== _loc3_)
                                                                                                                                                {
                                                                                                                                                   if(53 !== _loc3_)
                                                                                                                                                   {
                                                                                                                                                      if(98 !== _loc3_)
                                                                                                                                                      {
                                                                                                                                                         if(64 !== _loc3_)
                                                                                                                                                         {
                                                                                                                                                            if(60 !== _loc3_)
                                                                                                                                                            {
                                                                                                                                                               if(63 !== _loc3_)
                                                                                                                                                               {
                                                                                                                                                                  if(67 !== _loc3_)
                                                                                                                                                                  {
                                                                                                                                                                     if(48 !== _loc3_)
                                                                                                                                                                     {
                                                                                                                                                                        if(58 !== _loc3_)
                                                                                                                                                                        {
                                                                                                                                                                           if(56 !== _loc3_)
                                                                                                                                                                           {
                                                                                                                                                                              if(57 !== _loc3_)
                                                                                                                                                                              {
                                                                                                                                                                                 if(55 !== _loc3_)
                                                                                                                                                                                 {
                                                                                                                                                                                    if(59 !== _loc3_)
                                                                                                                                                                                    {
                                                                                                                                                                                       if(61 !== _loc3_)
                                                                                                                                                                                       {
                                                                                                                                                                                          if(89 !== _loc3_)
                                                                                                                                                                                          {
                                                                                                                                                                                             if(62 !== _loc3_)
                                                                                                                                                                                             {
                                                                                                                                                                                                if(119 !== _loc3_)
                                                                                                                                                                                                {
                                                                                                                                                                                                   if(120 !== _loc3_)
                                                                                                                                                                                                   {
                                                                                                                                                                                                      if(121 !== _loc3_)
                                                                                                                                                                                                      {
                                                                                                                                                                                                         if(68 !== _loc3_)
                                                                                                                                                                                                         {
                                                                                                                                                                                                            if(132 !== _loc3_)
                                                                                                                                                                                                            {
                                                                                                                                                                                                               if(69 !== _loc3_)
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  if(70 !== _loc3_)
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     if(71 !== _loc3_)
                                                                                                                                                                                                                     {
                                                                                                                                                                                                                        if(84 !== _loc3_)
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                           if(-1 !== _loc3_)
                                                                                                                                                                                                                           {
                                                                                                                                                                                                                              if(24 !== _loc3_)
                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                 if(133 !== _loc3_)
                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                    if(72 !== _loc3_)
                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                       if(73 !== _loc3_)
                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                          if(80 !== _loc3_)
                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                             if(134 !== _loc3_)
                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                if(223 !== _loc3_)
                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                   if(238 !== _loc3_)
                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                      if(239 !== _loc3_)
                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                         if(240 !== _loc3_)
                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                            if(135 !== _loc3_)
                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                               if(241 !== _loc3_)
                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                  if(221 !== _loc3_)
                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                     if(85 !== _loc3_)
                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                        if(144 !== _loc3_)
                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                           if(145 !== _loc3_)
                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                              if(146 !== _loc3_)
                                                                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                                                                 if(147 !== _loc3_)
                                                                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                                                                    if(86 !== _loc3_)
                                                                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                                                                       if(87 !== _loc3_)
                                                                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                                                                          if(148 !== _loc3_)
                                                                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                                                                             if(136 !== _loc3_)
                                                                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                                                                if(138 !== _loc3_)
                                                                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                                                                   if(220 !== _loc3_)
                                                                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                                                                      if(149 !== _loc3_)
                                                                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                                                                         if(74 !== _loc3_)
                                                                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                                                                            if(39 !== _loc3_)
                                                                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                                                                               if(76 !== _loc3_)
                                                                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                                                                  if(12 !== _loc3_)
                                                                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                                                                     if(77 !== _loc3_)
                                                                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                                                                        if(79 !== _loc3_)
                                                                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                                                                           if(92 !== _loc3_)
                                                                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                                                                              if(4 !== _loc3_)
                                                                                                                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                                                                                                                 _cmdID = Number(_cmdID) + 1;
                                                                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                                                                              else
                                                                                                                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                                                                                                                 event = new CrazyTankSocketEvent("roundOneEnd",_pkgVec[id]);
                                                                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                                                                           else
                                                                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                                                                              event = new CrazyTankSocketEvent("singleBattle_forecdExit",_pkgVec[id]);
                                                                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                                                                           event = new CrazyTankSocketEvent("add_animation",_pkgVec[id]);
                                                                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                                                                     else
                                                                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                                                                        event = new CrazyTankSocketEvent("gameClearDebuff",_pkgVec[id]);
                                                                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                                                                                  else
                                                                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                                                                     event = new CrazyTankSocketEvent("gameSkipNext",_pkgVec[id]);
                                                                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                                                                               else
                                                                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                                                                  event = new CrazyTankSocketEvent("gameFightStatus",_pkgVec[id]);
                                                                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                                                                               event = new CrazyTankSocketEvent("gameRevive",_pkgVec[id]);
                                                                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                                                                         else
                                                                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                                                                            event = new CrazyTankSocketEvent("singleBattleStartMatch",_pkgVec[id]);
                                                                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                                                                      else
                                                                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                                                                         event = new CrazyTankSocketEvent("game_trusteeship",_pkgVec[id]);
                                                                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                                                                   else
                                                                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                                                                      event = new CrazyTankSocketEvent("game_in_color_change",_pkgVec[id]);
                                                                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                                                                   event = new CrazyTankSocketEvent("selectObject",_pkgVec[id]);
                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                                                                             else
                                                                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                                                                event = new CrazyTankSocketEvent("PickBox",_pkgVec[id]);
                                                                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                                          else
                                                                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                                                                             event = new CrazyTankSocketEvent("wishofdd",_pkgVec[id]);
                                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                                                                       else
                                                                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                                                                          event = new CrazyTankSocketEvent("add_terrace",_pkgVec[id]);
                                                                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                                                                       event = new CrazyTankSocketEvent("add_new_player",_pkgVec[id]);
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                                                                    event = new CrazyTankSocketEvent("petSkillCD",_pkgVec[id]);
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                              else
                                                                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                                                                 event = new CrazyTankSocketEvent("petBeat",_pkgVec[id]);
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                           else
                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                              event = new CrazyTankSocketEvent("petBuff",_pkgVec[id]);
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                           event = new CrazyTankSocketEvent("usePetSkill",_pkgVec[id]);
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                     else
                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                        event = new CrazyTankSocketEvent("LivingChangeAngele",_pkgVec[id]);
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                                  else
                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                     event = new CrazyTankSocketEvent("gamesysmessage",_pkgVec[id]);
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                               else
                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                  event = new CrazyTankSocketEvent("windPic",_pkgVec[id]);
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                               event = new CrazyTankSocketEvent("changedMaxForce",_pkgVec[id]);
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                         else
                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                            event = new CrazyTankSocketEvent("removeSkill",_pkgVec[id]);
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                      else
                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                         event = new CrazyTankSocketEvent("applySkill",_pkgVec[id]);
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                   else
                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                      event = new CrazyTankSocketEvent("fightAchievement",_pkgVec[id]);
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                   event = new CrazyTankSocketEvent("actionMapping",_pkgVec[id]);
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                             else
                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                event = new CrazyTankSocketEvent("tempStyle",_pkgVec[id]);
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                          else
                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                             event = new CrazyTankSocketEvent("livingShowBlood",_pkgVec[id]);
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                       else
                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                          event = new CrazyTankSocketEvent("changeTarget",_pkgVec[id]);
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                       event = new CrazyTankSocketEvent("livingBoltmove",_pkgVec[id]);
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                    event = new CrazyTankSocketEvent("showPassStoryBtn",_pkgVec[id]);
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                              else
                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                 event = new CrazyTankSocketEvent("popupQuestionFrame",_pkgVec[id]);
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                           else
                                                                                                                                                                                                                           {
                                                                                                                                                                                                                              event = new CrazyTankSocketEvent("fightLibInfoChange",_pkgVec[id]);
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                        else
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                           event = new CrazyTankSocketEvent("Use_Deputy_Weapon",_pkgVec[id]);
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                     else
                                                                                                                                                                                                                     {
                                                                                                                                                                                                                        event = new CrazyTankSocketEvent("controlBGM",_pkgVec[id]);
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                  }
                                                                                                                                                                                                                  else
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     event = new CrazyTankSocketEvent("topLayer",_pkgVec[id]);
                                                                                                                                                                                                                  }
                                                                                                                                                                                                               }
                                                                                                                                                                                                               else
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  event = new CrazyTankSocketEvent("forbidDrag",_pkgVec[id]);
                                                                                                                                                                                                               }
                                                                                                                                                                                                            }
                                                                                                                                                                                                            else
                                                                                                                                                                                                            {
                                                                                                                                                                                                               event = new CrazyTankSocketEvent("playWordTip",_pkgVec[id]);
                                                                                                                                                                                                            }
                                                                                                                                                                                                         }
                                                                                                                                                                                                         else
                                                                                                                                                                                                         {
                                                                                                                                                                                                            event = new CrazyTankSocketEvent("addTipLayer",_pkgVec[id]);
                                                                                                                                                                                                         }
                                                                                                                                                                                                      }
                                                                                                                                                                                                      else
                                                                                                                                                                                                      {
                                                                                                                                                                                                         event = new CrazyTankSocketEvent("gameRoomInfo",_pkgVec[id]);
                                                                                                                                                                                                      }
                                                                                                                                                                                                   }
                                                                                                                                                                                                   else
                                                                                                                                                                                                   {
                                                                                                                                                                                                      event = new CrazyTankSocketEvent("playInfoInGame",_pkgVec[id]);
                                                                                                                                                                                                   }
                                                                                                                                                                                                }
                                                                                                                                                                                                else
                                                                                                                                                                                                {
                                                                                                                                                                                                   event = new CrazyTankSocketEvent("gameMissionTryAgain",_pkgVec[id]);
                                                                                                                                                                                                }
                                                                                                                                                                                             }
                                                                                                                                                                                             else
                                                                                                                                                                                             {
                                                                                                                                                                                                event = new CrazyTankSocketEvent("focusOnObject",_pkgVec[id]);
                                                                                                                                                                                             }
                                                                                                                                                                                          }
                                                                                                                                                                                          else
                                                                                                                                                                                          {
                                                                                                                                                                                             event = new CrazyTankSocketEvent("showCard",_pkgVec[id]);
                                                                                                                                                                                          }
                                                                                                                                                                                       }
                                                                                                                                                                                       else
                                                                                                                                                                                       {
                                                                                                                                                                                          event = new CrazyTankSocketEvent("livingRangeAttacking",_pkgVec[id]);
                                                                                                                                                                                       }
                                                                                                                                                                                    }
                                                                                                                                                                                    else
                                                                                                                                                                                    {
                                                                                                                                                                                       event = new CrazyTankSocketEvent("livingSay",_pkgVec[id]);
                                                                                                                                                                                    }
                                                                                                                                                                                 }
                                                                                                                                                                                 else
                                                                                                                                                                                 {
                                                                                                                                                                                    event = new CrazyTankSocketEvent("livingMoveTo",_pkgVec[id]);
                                                                                                                                                                                 }
                                                                                                                                                                              }
                                                                                                                                                                              else
                                                                                                                                                                              {
                                                                                                                                                                                 event = new CrazyTankSocketEvent("livingJump",_pkgVec[id]);
                                                                                                                                                                              }
                                                                                                                                                                           }
                                                                                                                                                                           else
                                                                                                                                                                           {
                                                                                                                                                                              event = new CrazyTankSocketEvent("livingFalling",_pkgVec[id]);
                                                                                                                                                                           }
                                                                                                                                                                        }
                                                                                                                                                                        else
                                                                                                                                                                        {
                                                                                                                                                                           event = new CrazyTankSocketEvent("livingBeat",_pkgVec[id]);
                                                                                                                                                                        }
                                                                                                                                                                     }
                                                                                                                                                                     else
                                                                                                                                                                     {
                                                                                                                                                                        event = new CrazyTankSocketEvent("addMapThing",_pkgVec[id]);
                                                                                                                                                                     }
                                                                                                                                                                  }
                                                                                                                                                                  else
                                                                                                                                                                  {
                                                                                                                                                                     event = new CrazyTankSocketEvent("loadResource",_pkgVec[id]);
                                                                                                                                                                  }
                                                                                                                                                               }
                                                                                                                                                               else
                                                                                                                                                               {
                                                                                                                                                                  event = new CrazyTankSocketEvent("playSound",_pkgVec[id]);
                                                                                                                                                               }
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                               event = new CrazyTankSocketEvent("playMovie",_pkgVec[id]);
                                                                                                                                                            }
                                                                                                                                                         }
                                                                                                                                                         else
                                                                                                                                                         {
                                                                                                                                                            event = new CrazyTankSocketEvent("addLiving",_pkgVec[id]);
                                                                                                                                                         }
                                                                                                                                                      }
                                                                                                                                                      else
                                                                                                                                                      {
                                                                                                                                                         event = new CrazyTankSocketEvent("gameTakeOut",_pkgVec[id]);
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                   else
                                                                                                                                                   {
                                                                                                                                                      event = new CrazyTankSocketEvent("boxdisappear",_pkgVec[id]);
                                                                                                                                                   }
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                   event = new CrazyTankSocketEvent("playerBeat",_pkgVec[id]);
                                                                                                                                                }
                                                                                                                                             }
                                                                                                                                             else
                                                                                                                                             {
                                                                                                                                                event = new CrazyTankSocketEvent("bombDie",_pkgVec[id]);
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                          else
                                                                                                                                          {
                                                                                                                                             event = new CrazyTankSocketEvent("playerPick",_pkgVec[id]);
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          event = new CrazyTankSocketEvent("changeBall",_pkgVec[id]);
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       event = new CrazyTankSocketEvent("playerShootTag",_pkgVec[id]);
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    event = new CrazyTankSocketEvent("suicide",_pkgVec[id]);
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 event = new CrazyTankSocketEvent("shootStaight",_pkgVec[id]);
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              event = new CrazyTankSocketEvent("playerAddBall",_pkgVec[id]);
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           event = new CrazyTankSocketEvent("playerAddAttack",_pkgVec[id]);
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        _cmdID = Number(_cmdID) + 1;
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     event = new CrazyTankSocketEvent("reduceDander",_pkgVec[id]);
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  event = new CrazyTankSocketEvent("playerDander",_pkgVec[id]);
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               event = new CrazyTankSocketEvent("playerProp",_pkgVec[id]);
                                                                                                            }
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            event = new CrazyTankSocketEvent("playerStunt",_pkgVec[id]);
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         event = new CrazyTankSocketEvent("playerFightProp",_pkgVec[id]);
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      event = new CrazyTankSocketEvent("playerBeckon",_pkgVec[id]);
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   id++;
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                event = new CrazyTankSocketEvent("playerHide",_pkgVec[id]);
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             event = new CrazyTankSocketEvent("playerVane",_pkgVec[id]);
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          event = new CrazyTankSocketEvent("playerInvincibly",_pkgVec[id]);
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       event = new CrazyTankSocketEvent("playerProperty",_pkgVec[id]);
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    event = new CrazyTankSocketEvent("changeState",_pkgVec[id]);
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 event = new CrazyTankSocketEvent("playerNoNole",_pkgVec[id]);
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              event = new CrazyTankSocketEvent("playerFrost",_pkgVec[id]);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           event = new CrazyTankSocketEvent("playerBlood",_pkgVec[id]);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        event = new CrazyTankSocketEvent("playerChange",_pkgVec[id]);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     event = new CrazyTankSocketEvent("playerStopMove",_pkgVec[id]);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  event = new CrazyTankSocketEvent("playerStartMove",_pkgVec[id]);
                                                               }
                                                            }
                                                            else if(QueueManager._waitlist.length <= 0)
                                                            {
                                                               _cmdID = Number(_cmdID) + 1;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            event = new CrazyTankSocketEvent("playerShoot",_pkgVec[id]);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         event = new CrazyTankSocketEvent("playerGunAngle",_pkgVec[id]);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      event = new CrazyTankSocketEvent("playerDirection",_pkgVec[id]);
                                                   }
                                                }
                                                else
                                                {
                                                   event = new CrazyTankSocketEvent("gameAllMissionOver",_pkgVec[id]);
                                                }
                                             }
                                             else
                                             {
                                                event = new CrazyTankSocketEvent("missionOver",_pkgVec[id]);
                                             }
                                          }
                                          else
                                          {
                                             event = new CrazyTankSocketEvent("gameOver",_pkgVec[id]);
                                          }
                                       }
                                       else
                                       {
                                          event = new CrazyTankSocketEvent("gameMissionInfo",_pkgVec[id]);
                                       }
                                    }
                                    else
                                    {
                                       event = new CrazyTankSocketEvent("gameLoad",_pkgVec[id]);
                                    }
                                 }
                                 else
                                 {
                                    event = new CrazyTankSocketEvent("gameWannaLeader",_pkgVec[id]);
                                 }
                              }
                              else if(RoomManager.Instance.current && RoomManager.Instance.current.selfRoomPlayer.progress >= 100)
                              {
                                 event = new CrazyTankSocketEvent("gameStart",_pkgVec[id]);
                              }
                           }
                           else
                           {
                              event = new CrazyTankSocketEvent("gameCreate",_pkgVec[id]);
                           }
                        }
                        else
                        {
                           event = new CrazyTankSocketEvent("barrierInfo",_pkgVec[id]);
                        }
                     }
                     else
                     {
                        event = new CrazyTankSocketEvent("addMapThing",_pkgVec[id]);
                     }
                  }
                  else
                  {
                     event = new CrazyTankSocketEvent("updateBoardState",_pkgVec[id]);
                  }
               }
               else
               {
                  event = new CrazyTankSocketEvent("gameMissionPrepare",_pkgVec[id]);
               }
            }
            else
            {
               event = new CrazyTankSocketEvent("updateBuff",_pkgVec[id]);
            }
         }
         else
         {
            event = new CrazyTankSocketEvent("gemGlow",_pkgVec[id]);
         }
         return event;
      }
      
      public function getFightReportLoader(reportID:String) : BaseLoader
      {
         var args:URLVariables = RequestVairableCreater.creatWidthKey(true);
         args["ID"] = reportID;
         var loader:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GetFightReport.ashx"),7,args);
         loader.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingFightReportFailure");
         loader.analyzer = new FightReportAnalyze(getFightInfo);
         return loader;
      }
      
      public function getFightInfo(analyzer:FightReportAnalyze) : void
      {
         var i:int = 0;
         var code:uint = 0;
         _pkgVec = analyzer.pkgVec;
         for(i = 0; i < _pkgVec.length; )
         {
            code = _pkgVec[i].readUnsignedByte();
            if((code == 101 || code == 103 || code == 99) && _cmdVec.indexOf(code) != -1)
            {
               _pkgVec.splice(i,1);
               i--;
            }
            else
            {
               if(code == 99)
               {
                  _startGameId = i + 1;
               }
               _cmdVec.push(code);
            }
            i++;
         }
         play();
      }
      
      private function play() : void
      {
         BombKingManager.instance.Recording = true;
         _frameSprite.addEventListener("enterFrame",__onEnterFrame);
      }
      
      public function reset() : void
      {
         _frameSprite.removeEventListener("enterFrame",__onEnterFrame);
         _cmdVec.length = 0;
         if(_pkgVec != null)
         {
            _pkgVec.length = 0;
         }
         _cmdID = 0;
      }
      
      public function getFightTime() : int
      {
         var time:int = 0;
         if(_pkgVec && _pkgVec.length > 0)
         {
            time = _pkgVec[_pkgVec.length - 1].extend2;
         }
         return time;
      }
      
      public function playByCmdId(time:int) : int
      {
         var i:int = 0;
         var event:* = null;
         var res:int = 0;
         var length:int = _pkgVec.length;
         for(i = _cmdID; i < length; )
         {
            if(time <= _pkgVec[i].extend2)
            {
               _cmdID = i;
               break;
            }
            event = creatGameEvent(i);
            if(event)
            {
               QueueManager.addQueue(event);
            }
            i++;
         }
         QueueManager.setLifeTime(_pkgVec[_cmdID].extend2);
         var id:int = 1;
         while(_cmdID - id >= _startGameId && _pkgVec[_cmdID - id].extend2 <= 0)
         {
            id++;
         }
         res = _pkgVec[_cmdID - id].extend2;
         return res;
      }
      
      public function printVec() : void
      {
         var i:int = 0;
         var length:int = _pkgVec.length;
         for(i = 0; i < length; )
         {
            if(_pkgVec[i].position == _pkgVec[i].length)
            {
               trace("协议号是：" + _cmdVec[i].toString(16) + "  时间是：" + _pkgVec[i].extend2);
            }
            i++;
         }
      }
      
      private function __onOpenView(event:BombKingEvent) : void
      {
         if(!_frame)
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",onSmallLoadingClose);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",createBombKingFrame);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUIProgress);
            UIModuleLoader.Instance.addUIModuleImp("bombKing");
         }
         else
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("bombKing.BombKingMainFrame");
            LayerManager.Instance.addToLayer(_frame,3,true,1);
         }
      }
      
      protected function onSmallLoadingClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",createBombKingFrame);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUIProgress);
      }
      
      protected function onUIProgress(event:UIModuleEvent) : void
      {
         if(event.module == "bombKing")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      protected function createBombKingFrame(event:UIModuleEvent) : void
      {
         if(event.module != "bombKing")
         {
            return;
         }
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",createBombKingFrame);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUIProgress);
         _frame = ComponentFactory.Instance.creatComponentByStylename("bombKing.BombKingMainFrame");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      public function get frame() : BombKingMainFrame
      {
         return _frame;
      }
      
      public function set frame(value:BombKingMainFrame) : void
      {
         _frame = value;
      }
   }
}
