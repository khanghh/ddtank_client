package zodiac
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import quest.TaskManager;
   
   public class ZodiacRollingView extends Sprite implements Disposeable
   {
       
      
      private var _rollingBtn:MovieClip;
      
      private var btndarkArr:Array;
      
      private var btnShineArr:Array;
      
      private var currentBtn:Image;
      
      private var paopaoArr:Array;
      
      private var finalMovie:MovieClip;
      
      private var _last:int;
      
      private var rollrace:int;
      
      private var rollcount:int;
      
      private var indexpaopao:int;
      
      private var endpaopao:int;
      
      public function ZodiacRollingView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function rolling(param1:int) : void
      {
         var _loc2_:int = 0;
         ZodiacControl.instance.inRolling = true;
         endpaopao = param1;
         _loc2_ = 0;
         while(_loc2_ < paopaoArr.length)
         {
            addChild(paopaoArr[_loc2_]);
            paopaoArr[_loc2_].visible = false;
            _loc2_++;
         }
         rollrace = 70;
         rollcount = 1;
         indexpaopao = 0;
      }
      
      private function startrolling() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MovieClip = paopaoArr[indexpaopao] as MovieClip;
         _loc1_.visible = true;
         _loc1_.gotoAndPlay(1);
         if(indexpaopao == 11)
         {
            §§push(0);
         }
         else
         {
            indexpaopao = indexpaopao + 1;
            §§push(indexpaopao + 1);
         }
         indexpaopao = §§pop();
         if(indexpaopao == 0)
         {
            rollcount = rollcount + 1;
            §§push(rollcount + 1);
         }
         else
         {
            §§push(int(rollcount));
         }
         rollcount = §§pop();
         if(rollcount == 2)
         {
            rollrace = rollrace - 4;
         }
         else if(rollcount >= 6)
         {
            rollrace = rollrace + 4;
         }
         if(rollcount < 8)
         {
            setTimeout(startrolling,rollrace);
         }
         else if(indexpaopao == endpaopao || endpaopao == 12 && indexpaopao == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < paopaoArr.length)
            {
               removeChild(paopaoArr[_loc2_]);
               _loc2_++;
            }
            rollingComplete(endpaopao);
         }
         else
         {
            setTimeout(startrolling,rollrace);
         }
      }
      
      private function rolltest() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < paopaoArr.length)
         {
            addChild(paopaoArr[_loc1_]);
            paopaoArr[_loc1_].visible = false;
            _loc1_++;
         }
         rollrace = 70;
         rollcount = 1;
         indexpaopao = 0;
      }
      
      private function initView() : void
      {
         var _loc9_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc1_:* = null;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         _loc9_ = 1;
         while(_loc9_ <= 12)
         {
            _loc5_ = ComponentFactory.Instance.creatBitmap("zodiac.rollingview.line");
            addChild(_loc5_);
            PositionUtils.setPos(_loc5_,"zodiac.rollingview.backline.pos" + _loc9_);
            _loc5_.rotation = (_loc9_ - 1) * 30;
            _loc2_ = ComponentFactory.Instance.creatBitmap("zodiac.rollingview.ball.bg");
            addChild(_loc2_);
            PositionUtils.setPos(_loc2_,"zodiac.rollingview.ballgb.pos" + _loc9_);
            _loc9_++;
         }
         if(btndarkArr == null)
         {
            btndarkArr = [];
         }
         _loc7_ = 1;
         while(_loc7_ <= 12)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("zodiac.rollingview.darkbtnball" + _loc7_);
            addChild(_loc4_);
            _loc4_.buttonMode = true;
            _loc4_.mouseEnabled = false;
            _loc4_.addEventListener("click",__ballClickHandler);
            PositionUtils.setPos(_loc4_,"zodiac.rollingview.darkbtnball.pos" + _loc7_);
            btndarkArr.push(_loc4_);
            _loc7_++;
         }
         if(btnShineArr == null)
         {
            btnShineArr = [];
         }
         _loc8_ = 0;
         while(_loc8_ < 12)
         {
            _loc1_ = ClassUtils.CreatInstance("zodiac.rollingview.notcomplete.shine");
            PositionUtils.setPos(_loc1_,"zodiac.rollingview.btnshine.pos" + _loc8_);
            btnShineArr.push(_loc1_);
            _loc8_++;
         }
         if(paopaoArr == null)
         {
            paopaoArr = [];
         }
         _loc6_ = 0;
         while(_loc6_ < 12)
         {
            _loc3_ = ClassUtils.CreatInstance("zodiac.rollingview.ball.shine");
            PositionUtils.setPos(_loc3_,"zodiac.rollingview.paopao.pos" + _loc6_);
            paopaoArr.push(_loc3_);
            _loc6_++;
         }
         finalMovie = ClassUtils.CreatInstance("zodiac.rollingview.finalstop");
         addChild(finalMovie);
         hideFinalMovie();
         _rollingBtn = ClassUtils.CreatInstance("zodiac.rollingview.rolling.btn");
         _rollingBtn.buttonMode = true;
         _rollingBtn.mouseEnabled = true;
         PositionUtils.setPos(_rollingBtn,"zodiac.rollingview.rollingbtn.pos");
         addChild(_rollingBtn);
         update();
         refreshBallState();
         refreshShineState();
      }
      
      private function initEvent() : void
      {
         _rollingBtn.addEventListener("rollOver",__rolloverHandler);
         _rollingBtn.addEventListener("rollOut",__outHandler);
         _rollingBtn.addEventListener("click",__rollingHandler);
      }
      
      private function removeEvent() : void
      {
         _rollingBtn.removeEventListener("rollOver",__rolloverHandler);
         _rollingBtn.removeEventListener("rollOut",__outHandler);
         _rollingBtn.removeEventListener("click",__rollingHandler);
      }
      
      private function __rolloverHandler(param1:MouseEvent) : void
      {
         _rollingBtn.gotoAndPlay("move");
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _rollingBtn.gotoAndPlay(1);
      }
      
      private function __rollingHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         _rollingBtn.gotoAndPlay("down");
         if(ZodiacControl.instance.inRolling)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.inrolling"));
            return;
         }
         if(_last > 0)
         {
            SocketManager.Instance.out.zodiacRolling();
            hideFinalMovie();
            removeCurrentPaopao();
         }
         else
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("zodiac.mainview.addCountstip",ServerConfigManager.instance.zodiacAddPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
            _loc2_.addEventListener("response",__onAlertResponse);
         }
      }
      
      private function __onAlertResponse(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertResponse);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,ServerConfigManager.instance.zodiacAddPrice,onCompleteHandler);
         }
         _loc2_.dispose();
      }
      
      private function onCompleteHandler() : void
      {
         SocketManager.Instance.out.zodiacAddCounts(CheckMoneyUtils.instance.isBind);
      }
      
      private function __ballClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.play("008");
         if(ZodiacControl.instance.inRolling)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.inrolling"));
            return;
         }
         var _loc2_:Image = param1.currentTarget as Image;
         _loc3_ = 0;
         while(_loc3_ < btndarkArr.length)
         {
            if(btndarkArr[_loc3_] == _loc2_)
            {
               ZodiacControl.instance.setCurrentIndexView(_loc3_ + 1);
            }
            _loc3_++;
         }
         if(finalMovie.visible == true)
         {
            refreshBallState();
            refreshShineState();
         }
         hideFinalMovie();
         removeCurrentPaopao();
      }
      
      public function update() : void
      {
         _last = ZodiacModel.instance.maxCounts - ZodiacModel.instance.finshedCounts;
         if(ZodiacModel.instance.questCounts == 12)
         {
            _rollingBtn.buttonMode = false;
            _rollingBtn.mouseEnabled = false;
            _rollingBtn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            _rollingBtn.buttonMode = true;
            _rollingBtn.mouseEnabled = true;
            _rollingBtn.filters = [];
         }
         refreshShineState();
      }
      
      private function refreshBallState() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Array = ZodiacModel.instance.questArr;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = btndarkArr[_loc3_] as Image;
            if(_loc2_[_loc3_] != 0)
            {
               _loc1_.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               _loc1_.mouseEnabled = true;
            }
            else
            {
               _loc1_.filters = [];
               _loc1_.mouseEnabled = false;
            }
            _loc3_++;
         }
      }
      
      private function refreshShineState() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = 0;
         var _loc2_:Array = ZodiacModel.instance.questArr;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if(_loc2_[_loc4_] != 0)
            {
               _loc3_ = TaskManager.instance.getQuestByID(_loc2_[_loc4_]);
               if((ZodiacModel.instance.awardRecord >> _loc4_ + 1 & 1) == 1)
               {
                  if(btnShineArr[_loc4_].parent)
                  {
                     btnShineArr[_loc4_].parent.removeChild(btnShineArr[_loc4_]);
                  }
               }
               else if(_loc3_.isAchieved)
               {
                  if(btnShineArr[_loc4_].parent)
                  {
                     btnShineArr[_loc4_].parent.removeChild(btnShineArr[_loc4_]);
                  }
               }
               else if(!(endpaopao == _loc4_ + 1 && ZodiacControl.instance.inRolling == true))
               {
                  _loc1_ = 0;
                  _loc1_ = this.getChildIndex(finalMovie);
                  addChildAt(btnShineArr[_loc4_],_loc1_);
               }
            }
            else if(btnShineArr[_loc4_].parent)
            {
               btnShineArr[_loc4_].parent.removeChild(btnShineArr[_loc4_]);
            }
            _loc4_++;
         }
      }
      
      private function hideFinalMovie() : void
      {
         finalMovie.visible = false;
      }
      
      private function showFinalMovie(param1:int) : void
      {
         PositionUtils.setPos(finalMovie,"zodiac.rollingview.finalmc.pos" + param1);
         finalMovie.rotation = 300 - 30 * param1;
         finalMovie.visible = true;
         finalMovie.gotoAndPlay(1);
      }
      
      private function addCurrentPaopao(param1:int) : void
      {
         currentBtn = ComponentFactory.Instance.creatComponentByStylename("zodiac.rollingview.lightbtnball" + param1);
         var _loc2_:int = this.getChildIndex(finalMovie);
         addChildAt(currentBtn,_loc2_);
         PositionUtils.setPos(currentBtn,"zodiac.rollingview.darkbtnball.pos" + param1);
      }
      
      private function removeCurrentPaopao() : void
      {
         if(currentBtn != null)
         {
            removeChild(currentBtn);
            currentBtn = null;
         }
      }
      
      private function rollingComplete(param1:int) : void
      {
         removeCurrentPaopao();
         addCurrentPaopao(param1);
         showFinalMovie(param1);
         refreshBallState();
         refreshShineState();
         ZodiacControl.instance.inRolling = false;
         ZodiacControl.instance.setCurrentIndexView(param1);
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.rollingcompletemsg"));
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.removeChildAllChildren(this);
      }
   }
}
