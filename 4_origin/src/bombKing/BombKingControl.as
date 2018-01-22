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
      
      protected function __onStartLoadBattleXml(param1:BombKingEvent) : void
      {
         var _loc2_:BaseLoader = getFightReportLoader(ReportID);
         LoadResourceManager.Instance.startLoad(_loc2_);
      }
      
      protected function __showTip(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         isOpen = _loc2_.readBoolean();
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
      
      protected function __onEnterFrame(param1:Event) : void
      {
         var _loc2_:CrazyTankSocketEvent = null;
         if(_cmdID < _cmdVec.length)
         {
            _loc2_ = creatGameEvent(_cmdID);
            if(_loc2_)
            {
               QueueManager.addQueue(_loc2_);
               _cmdID = Number(_cmdID) + 1;
            }
         }
         else
         {
            reset();
         }
      }
      
      private function creatGameEvent(param1:int) : CrazyTankSocketEvent
      {
         var _loc2_:CrazyTankSocketEvent = null;
         var _loc3_:* = _cmdVec[param1];
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
                                                                                                                                                                                                                                                                                                                                 _loc2_ = new CrazyTankSocketEvent("roundOneEnd",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                                                                           else
                                                                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                                                                              _loc2_ = new CrazyTankSocketEvent("singleBattle_forecdExit",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                                                                           _loc2_ = new CrazyTankSocketEvent("add_animation",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                                                                     else
                                                                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                                                                        _loc2_ = new CrazyTankSocketEvent("gameClearDebuff",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                                                                                  else
                                                                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                                                                     _loc2_ = new CrazyTankSocketEvent("gameSkipNext",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                                                                               else
                                                                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                                                                  _loc2_ = new CrazyTankSocketEvent("gameFightStatus",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                                                                               _loc2_ = new CrazyTankSocketEvent("gameRevive",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                                                                         else
                                                                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                                                                            _loc2_ = new CrazyTankSocketEvent("singleBattleStartMatch",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                                                                      else
                                                                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                                                                         _loc2_ = new CrazyTankSocketEvent("game_trusteeship",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                                                                   else
                                                                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                                                                      _loc2_ = new CrazyTankSocketEvent("game_in_color_change",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                                                                   _loc2_ = new CrazyTankSocketEvent("selectObject",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                                                                             else
                                                                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                                                                _loc2_ = new CrazyTankSocketEvent("PickBox",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                                          else
                                                                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                                                                             _loc2_ = new CrazyTankSocketEvent("wishofdd",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                                                                       else
                                                                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                                                                          _loc2_ = new CrazyTankSocketEvent("add_terrace",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                                                                       _loc2_ = new CrazyTankSocketEvent("add_new_player",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                                                                    _loc2_ = new CrazyTankSocketEvent("petSkillCD",_pkgVec[param1]);
                                                                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                              else
                                                                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                                                                 _loc2_ = new CrazyTankSocketEvent("petBeat",_pkgVec[param1]);
                                                                                                                                                                                                                                                                              }
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                           else
                                                                                                                                                                                                                                                                           {
                                                                                                                                                                                                                                                                              _loc2_ = new CrazyTankSocketEvent("petBuff",_pkgVec[param1]);
                                                                                                                                                                                                                                                                           }
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                        else
                                                                                                                                                                                                                                                                        {
                                                                                                                                                                                                                                                                           _loc2_ = new CrazyTankSocketEvent("usePetSkill",_pkgVec[param1]);
                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                     else
                                                                                                                                                                                                                                                                     {
                                                                                                                                                                                                                                                                        _loc2_ = new CrazyTankSocketEvent("LivingChangeAngele",_pkgVec[param1]);
                                                                                                                                                                                                                                                                     }
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                                  else
                                                                                                                                                                                                                                                                  {
                                                                                                                                                                                                                                                                     _loc2_ = new CrazyTankSocketEvent("gamesysmessage",_pkgVec[param1]);
                                                                                                                                                                                                                                                                  }
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                               else
                                                                                                                                                                                                                                                               {
                                                                                                                                                                                                                                                                  _loc2_ = new CrazyTankSocketEvent("windPic",_pkgVec[param1]);
                                                                                                                                                                                                                                                               }
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                            else
                                                                                                                                                                                                                                                            {
                                                                                                                                                                                                                                                               _loc2_ = new CrazyTankSocketEvent("changedMaxForce",_pkgVec[param1]);
                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                         else
                                                                                                                                                                                                                                                         {
                                                                                                                                                                                                                                                            _loc2_ = new CrazyTankSocketEvent("removeSkill",_pkgVec[param1]);
                                                                                                                                                                                                                                                         }
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                      else
                                                                                                                                                                                                                                                      {
                                                                                                                                                                                                                                                         _loc2_ = new CrazyTankSocketEvent("applySkill",_pkgVec[param1]);
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                   else
                                                                                                                                                                                                                                                   {
                                                                                                                                                                                                                                                      _loc2_ = new CrazyTankSocketEvent("fightAchievement",_pkgVec[param1]);
                                                                                                                                                                                                                                                   }
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                                else
                                                                                                                                                                                                                                                {
                                                                                                                                                                                                                                                   _loc2_ = new CrazyTankSocketEvent("actionMapping",_pkgVec[param1]);
                                                                                                                                                                                                                                                }
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                             else
                                                                                                                                                                                                                                             {
                                                                                                                                                                                                                                                _loc2_ = new CrazyTankSocketEvent("tempStyle",_pkgVec[param1]);
                                                                                                                                                                                                                                             }
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                          else
                                                                                                                                                                                                                                          {
                                                                                                                                                                                                                                             _loc2_ = new CrazyTankSocketEvent("livingShowBlood",_pkgVec[param1]);
                                                                                                                                                                                                                                          }
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                       else
                                                                                                                                                                                                                                       {
                                                                                                                                                                                                                                          _loc2_ = new CrazyTankSocketEvent("changeTarget",_pkgVec[param1]);
                                                                                                                                                                                                                                       }
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                    else
                                                                                                                                                                                                                                    {
                                                                                                                                                                                                                                       _loc2_ = new CrazyTankSocketEvent("livingBoltmove",_pkgVec[param1]);
                                                                                                                                                                                                                                    }
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                                 else
                                                                                                                                                                                                                                 {
                                                                                                                                                                                                                                    _loc2_ = new CrazyTankSocketEvent("showPassStoryBtn",_pkgVec[param1]);
                                                                                                                                                                                                                                 }
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                              else
                                                                                                                                                                                                                              {
                                                                                                                                                                                                                                 _loc2_ = new CrazyTankSocketEvent("popupQuestionFrame",_pkgVec[param1]);
                                                                                                                                                                                                                              }
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                           else
                                                                                                                                                                                                                           {
                                                                                                                                                                                                                              _loc2_ = new CrazyTankSocketEvent("fightLibInfoChange",_pkgVec[param1]);
                                                                                                                                                                                                                           }
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                        else
                                                                                                                                                                                                                        {
                                                                                                                                                                                                                           _loc2_ = new CrazyTankSocketEvent("Use_Deputy_Weapon",_pkgVec[param1]);
                                                                                                                                                                                                                        }
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                     else
                                                                                                                                                                                                                     {
                                                                                                                                                                                                                        _loc2_ = new CrazyTankSocketEvent("controlBGM",_pkgVec[param1]);
                                                                                                                                                                                                                     }
                                                                                                                                                                                                                  }
                                                                                                                                                                                                                  else
                                                                                                                                                                                                                  {
                                                                                                                                                                                                                     _loc2_ = new CrazyTankSocketEvent("topLayer",_pkgVec[param1]);
                                                                                                                                                                                                                  }
                                                                                                                                                                                                               }
                                                                                                                                                                                                               else
                                                                                                                                                                                                               {
                                                                                                                                                                                                                  _loc2_ = new CrazyTankSocketEvent("forbidDrag",_pkgVec[param1]);
                                                                                                                                                                                                               }
                                                                                                                                                                                                            }
                                                                                                                                                                                                            else
                                                                                                                                                                                                            {
                                                                                                                                                                                                               _loc2_ = new CrazyTankSocketEvent("playWordTip",_pkgVec[param1]);
                                                                                                                                                                                                            }
                                                                                                                                                                                                         }
                                                                                                                                                                                                         else
                                                                                                                                                                                                         {
                                                                                                                                                                                                            _loc2_ = new CrazyTankSocketEvent("addTipLayer",_pkgVec[param1]);
                                                                                                                                                                                                         }
                                                                                                                                                                                                      }
                                                                                                                                                                                                      else
                                                                                                                                                                                                      {
                                                                                                                                                                                                         _loc2_ = new CrazyTankSocketEvent("gameRoomInfo",_pkgVec[param1]);
                                                                                                                                                                                                      }
                                                                                                                                                                                                   }
                                                                                                                                                                                                   else
                                                                                                                                                                                                   {
                                                                                                                                                                                                      _loc2_ = new CrazyTankSocketEvent("playInfoInGame",_pkgVec[param1]);
                                                                                                                                                                                                   }
                                                                                                                                                                                                }
                                                                                                                                                                                                else
                                                                                                                                                                                                {
                                                                                                                                                                                                   _loc2_ = new CrazyTankSocketEvent("gameMissionTryAgain",_pkgVec[param1]);
                                                                                                                                                                                                }
                                                                                                                                                                                             }
                                                                                                                                                                                             else
                                                                                                                                                                                             {
                                                                                                                                                                                                _loc2_ = new CrazyTankSocketEvent("focusOnObject",_pkgVec[param1]);
                                                                                                                                                                                             }
                                                                                                                                                                                          }
                                                                                                                                                                                          else
                                                                                                                                                                                          {
                                                                                                                                                                                             _loc2_ = new CrazyTankSocketEvent("showCard",_pkgVec[param1]);
                                                                                                                                                                                          }
                                                                                                                                                                                       }
                                                                                                                                                                                       else
                                                                                                                                                                                       {
                                                                                                                                                                                          _loc2_ = new CrazyTankSocketEvent("livingRangeAttacking",_pkgVec[param1]);
                                                                                                                                                                                       }
                                                                                                                                                                                    }
                                                                                                                                                                                    else
                                                                                                                                                                                    {
                                                                                                                                                                                       _loc2_ = new CrazyTankSocketEvent("livingSay",_pkgVec[param1]);
                                                                                                                                                                                    }
                                                                                                                                                                                 }
                                                                                                                                                                                 else
                                                                                                                                                                                 {
                                                                                                                                                                                    _loc2_ = new CrazyTankSocketEvent("livingMoveTo",_pkgVec[param1]);
                                                                                                                                                                                 }
                                                                                                                                                                              }
                                                                                                                                                                              else
                                                                                                                                                                              {
                                                                                                                                                                                 _loc2_ = new CrazyTankSocketEvent("livingJump",_pkgVec[param1]);
                                                                                                                                                                              }
                                                                                                                                                                           }
                                                                                                                                                                           else
                                                                                                                                                                           {
                                                                                                                                                                              _loc2_ = new CrazyTankSocketEvent("livingFalling",_pkgVec[param1]);
                                                                                                                                                                           }
                                                                                                                                                                        }
                                                                                                                                                                        else
                                                                                                                                                                        {
                                                                                                                                                                           _loc2_ = new CrazyTankSocketEvent("livingBeat",_pkgVec[param1]);
                                                                                                                                                                        }
                                                                                                                                                                     }
                                                                                                                                                                     else
                                                                                                                                                                     {
                                                                                                                                                                        _loc2_ = new CrazyTankSocketEvent("addMapThing",_pkgVec[param1]);
                                                                                                                                                                     }
                                                                                                                                                                  }
                                                                                                                                                                  else
                                                                                                                                                                  {
                                                                                                                                                                     _loc2_ = new CrazyTankSocketEvent("loadResource",_pkgVec[param1]);
                                                                                                                                                                  }
                                                                                                                                                               }
                                                                                                                                                               else
                                                                                                                                                               {
                                                                                                                                                                  _loc2_ = new CrazyTankSocketEvent("playSound",_pkgVec[param1]);
                                                                                                                                                               }
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                               _loc2_ = new CrazyTankSocketEvent("playMovie",_pkgVec[param1]);
                                                                                                                                                            }
                                                                                                                                                         }
                                                                                                                                                         else
                                                                                                                                                         {
                                                                                                                                                            _loc2_ = new CrazyTankSocketEvent("addLiving",_pkgVec[param1]);
                                                                                                                                                         }
                                                                                                                                                      }
                                                                                                                                                      else
                                                                                                                                                      {
                                                                                                                                                         _loc2_ = new CrazyTankSocketEvent("gameTakeOut",_pkgVec[param1]);
                                                                                                                                                      }
                                                                                                                                                   }
                                                                                                                                                   else
                                                                                                                                                   {
                                                                                                                                                      _loc2_ = new CrazyTankSocketEvent("boxdisappear",_pkgVec[param1]);
                                                                                                                                                   }
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                   _loc2_ = new CrazyTankSocketEvent("playerBeat",_pkgVec[param1]);
                                                                                                                                                }
                                                                                                                                             }
                                                                                                                                             else
                                                                                                                                             {
                                                                                                                                                _loc2_ = new CrazyTankSocketEvent("bombDie",_pkgVec[param1]);
                                                                                                                                             }
                                                                                                                                          }
                                                                                                                                          else
                                                                                                                                          {
                                                                                                                                             _loc2_ = new CrazyTankSocketEvent("playerPick",_pkgVec[param1]);
                                                                                                                                          }
                                                                                                                                       }
                                                                                                                                       else
                                                                                                                                       {
                                                                                                                                          _loc2_ = new CrazyTankSocketEvent("changeBall",_pkgVec[param1]);
                                                                                                                                       }
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                       _loc2_ = new CrazyTankSocketEvent("playerShootTag",_pkgVec[param1]);
                                                                                                                                    }
                                                                                                                                 }
                                                                                                                                 else
                                                                                                                                 {
                                                                                                                                    _loc2_ = new CrazyTankSocketEvent("suicide",_pkgVec[param1]);
                                                                                                                                 }
                                                                                                                              }
                                                                                                                              else
                                                                                                                              {
                                                                                                                                 _loc2_ = new CrazyTankSocketEvent("shootStaight",_pkgVec[param1]);
                                                                                                                              }
                                                                                                                           }
                                                                                                                           else
                                                                                                                           {
                                                                                                                              _loc2_ = new CrazyTankSocketEvent("playerAddBall",_pkgVec[param1]);
                                                                                                                           }
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                           _loc2_ = new CrazyTankSocketEvent("playerAddAttack",_pkgVec[param1]);
                                                                                                                        }
                                                                                                                     }
                                                                                                                     else
                                                                                                                     {
                                                                                                                        _cmdID = Number(_cmdID) + 1;
                                                                                                                     }
                                                                                                                  }
                                                                                                                  else
                                                                                                                  {
                                                                                                                     _loc2_ = new CrazyTankSocketEvent("reduceDander",_pkgVec[param1]);
                                                                                                                  }
                                                                                                               }
                                                                                                               else
                                                                                                               {
                                                                                                                  _loc2_ = new CrazyTankSocketEvent("playerDander",_pkgVec[param1]);
                                                                                                               }
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                               _loc2_ = new CrazyTankSocketEvent("playerProp",_pkgVec[param1]);
                                                                                                            }
                                                                                                         }
                                                                                                         else
                                                                                                         {
                                                                                                            _loc2_ = new CrazyTankSocketEvent("playerStunt",_pkgVec[param1]);
                                                                                                         }
                                                                                                      }
                                                                                                      else
                                                                                                      {
                                                                                                         _loc2_ = new CrazyTankSocketEvent("playerFightProp",_pkgVec[param1]);
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      _loc2_ = new CrazyTankSocketEvent("playerBeckon",_pkgVec[param1]);
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   param1++;
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                _loc2_ = new CrazyTankSocketEvent("playerHide",_pkgVec[param1]);
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             _loc2_ = new CrazyTankSocketEvent("playerVane",_pkgVec[param1]);
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          _loc2_ = new CrazyTankSocketEvent("playerInvincibly",_pkgVec[param1]);
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       _loc2_ = new CrazyTankSocketEvent("playerProperty",_pkgVec[param1]);
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    _loc2_ = new CrazyTankSocketEvent("changeState",_pkgVec[param1]);
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc2_ = new CrazyTankSocketEvent("playerNoNole",_pkgVec[param1]);
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc2_ = new CrazyTankSocketEvent("playerFrost",_pkgVec[param1]);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           _loc2_ = new CrazyTankSocketEvent("playerBlood",_pkgVec[param1]);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc2_ = new CrazyTankSocketEvent("playerChange",_pkgVec[param1]);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     _loc2_ = new CrazyTankSocketEvent("playerStopMove",_pkgVec[param1]);
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  _loc2_ = new CrazyTankSocketEvent("playerStartMove",_pkgVec[param1]);
                                                               }
                                                            }
                                                            else if(QueueManager._waitlist.length <= 0)
                                                            {
                                                               _cmdID = Number(_cmdID) + 1;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            _loc2_ = new CrazyTankSocketEvent("playerShoot",_pkgVec[param1]);
                                                         }
                                                      }
                                                      else
                                                      {
                                                         _loc2_ = new CrazyTankSocketEvent("playerGunAngle",_pkgVec[param1]);
                                                      }
                                                   }
                                                   else
                                                   {
                                                      _loc2_ = new CrazyTankSocketEvent("playerDirection",_pkgVec[param1]);
                                                   }
                                                }
                                                else
                                                {
                                                   _loc2_ = new CrazyTankSocketEvent("gameAllMissionOver",_pkgVec[param1]);
                                                }
                                             }
                                             else
                                             {
                                                _loc2_ = new CrazyTankSocketEvent("missionOver",_pkgVec[param1]);
                                             }
                                          }
                                          else
                                          {
                                             _loc2_ = new CrazyTankSocketEvent("gameOver",_pkgVec[param1]);
                                          }
                                       }
                                       else
                                       {
                                          _loc2_ = new CrazyTankSocketEvent("gameMissionInfo",_pkgVec[param1]);
                                       }
                                    }
                                    else
                                    {
                                       _loc2_ = new CrazyTankSocketEvent("gameLoad",_pkgVec[param1]);
                                    }
                                 }
                                 else
                                 {
                                    _loc2_ = new CrazyTankSocketEvent("gameWannaLeader",_pkgVec[param1]);
                                 }
                              }
                              else if(RoomManager.Instance.current && RoomManager.Instance.current.selfRoomPlayer.progress >= 100)
                              {
                                 _loc2_ = new CrazyTankSocketEvent("gameStart",_pkgVec[param1]);
                              }
                           }
                           else
                           {
                              _loc2_ = new CrazyTankSocketEvent("gameCreate",_pkgVec[param1]);
                           }
                        }
                        else
                        {
                           _loc2_ = new CrazyTankSocketEvent("barrierInfo",_pkgVec[param1]);
                        }
                     }
                     else
                     {
                        _loc2_ = new CrazyTankSocketEvent("addMapThing",_pkgVec[param1]);
                     }
                  }
                  else
                  {
                     _loc2_ = new CrazyTankSocketEvent("updateBoardState",_pkgVec[param1]);
                  }
               }
               else
               {
                  _loc2_ = new CrazyTankSocketEvent("gameMissionPrepare",_pkgVec[param1]);
               }
            }
            else
            {
               _loc2_ = new CrazyTankSocketEvent("updateBuff",_pkgVec[param1]);
            }
         }
         else
         {
            _loc2_ = new CrazyTankSocketEvent("gemGlow",_pkgVec[param1]);
         }
         return _loc2_;
      }
      
      public function getFightReportLoader(param1:String) : BaseLoader
      {
         var _loc3_:URLVariables = RequestVairableCreater.creatWidthKey(true);
         _loc3_["ID"] = param1;
         var _loc2_:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.solveRequestPath("GetFightReport.ashx"),7,_loc3_);
         _loc2_.loadErrorMessage = LanguageMgr.GetTranslation("ddt.loader.LoadingFightReportFailure");
         _loc2_.analyzer = new FightReportAnalyze(getFightInfo);
         return _loc2_;
      }
      
      public function getFightInfo(param1:FightReportAnalyze) : void
      {
         var _loc3_:int = 0;
         var _loc2_:uint = 0;
         _pkgVec = param1.pkgVec;
         _loc3_ = 0;
         while(_loc3_ < _pkgVec.length)
         {
            _loc2_ = _pkgVec[_loc3_].readUnsignedByte();
            if((_loc2_ == 101 || _loc2_ == 103 || _loc2_ == 99) && _cmdVec.indexOf(_loc2_) != -1)
            {
               _pkgVec.splice(_loc3_,1);
               _loc3_--;
            }
            else
            {
               if(_loc2_ == 99)
               {
                  _startGameId = _loc3_ + 1;
               }
               _cmdVec.push(_loc2_);
            }
            _loc3_++;
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
         var _loc1_:int = 0;
         if(_pkgVec && _pkgVec.length > 0)
         {
            _loc1_ = _pkgVec[_pkgVec.length - 1].extend2;
         }
         return _loc1_;
      }
      
      public function playByCmdId(param1:int) : int
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc5_:int = _pkgVec.length;
         _loc6_ = _cmdID;
         while(_loc6_ < _loc5_)
         {
            if(param1 <= _pkgVec[_loc6_].extend2)
            {
               _cmdID = _loc6_;
               break;
            }
            _loc4_ = creatGameEvent(_loc6_);
            if(_loc4_)
            {
               QueueManager.addQueue(_loc4_);
            }
            _loc6_++;
         }
         QueueManager.setLifeTime(_pkgVec[_cmdID].extend2);
         var _loc2_:int = 1;
         while(_cmdID - _loc2_ >= _startGameId && _pkgVec[_cmdID - _loc2_].extend2 <= 0)
         {
            _loc2_++;
         }
         _loc3_ = _pkgVec[_cmdID - _loc2_].extend2;
         return _loc3_;
      }
      
      public function printVec() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _pkgVec.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_pkgVec[_loc2_].position == _pkgVec[_loc2_].length)
            {
               trace("协议号是：" + _cmdVec[_loc2_].toString(16) + "  时间是：" + _pkgVec[_loc2_].extend2);
            }
            _loc2_++;
         }
      }
      
      private function __onOpenView(param1:BombKingEvent) : void
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
      
      protected function onSmallLoadingClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",onSmallLoadingClose);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",createBombKingFrame);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUIProgress);
      }
      
      protected function onUIProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "bombKing")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      protected function createBombKingFrame(param1:UIModuleEvent) : void
      {
         if(param1.module != "bombKing")
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
      
      public function set frame(param1:BombKingMainFrame) : void
      {
         _frame = param1;
      }
   }
}
