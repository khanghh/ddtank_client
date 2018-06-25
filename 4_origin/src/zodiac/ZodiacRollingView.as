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
      
      public function rolling(index:int) : void
      {
         var i:int = 0;
         ZodiacControl.instance.inRolling = true;
         endpaopao = index;
         for(i = 0; i < paopaoArr.length; )
         {
            addChild(paopaoArr[i]);
            paopaoArr[i].visible = false;
            i++;
         }
         rollrace = 70;
         rollcount = 1;
         indexpaopao = 0;
      }
      
      private function startrolling() : void
      {
         var j:int = 0;
         var paopao:MovieClip = paopaoArr[indexpaopao] as MovieClip;
         paopao.visible = true;
         paopao.gotoAndPlay(1);
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
            for(j = 0; j < paopaoArr.length; )
            {
               removeChild(paopaoArr[j]);
               j++;
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
         var i:int = 0;
         for(i = 0; i < paopaoArr.length; )
         {
            addChild(paopaoArr[i]);
            paopaoArr[i].visible = false;
            i++;
         }
         rollrace = 70;
         rollcount = 1;
         indexpaopao = 0;
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var line:* = null;
         var di:* = null;
         var j:int = 0;
         var dark:* = null;
         var k:int = 0;
         var mc:* = null;
         var l:int = 0;
         var paopao:* = null;
         for(i = 1; i <= 12; )
         {
            line = ComponentFactory.Instance.creatBitmap("zodiac.rollingview.line");
            addChild(line);
            PositionUtils.setPos(line,"zodiac.rollingview.backline.pos" + i);
            line.rotation = (i - 1) * 30;
            di = ComponentFactory.Instance.creatBitmap("zodiac.rollingview.ball.bg");
            addChild(di);
            PositionUtils.setPos(di,"zodiac.rollingview.ballgb.pos" + i);
            i++;
         }
         if(btndarkArr == null)
         {
            btndarkArr = [];
         }
         j = 1;
         while(j <= 12)
         {
            dark = ComponentFactory.Instance.creatComponentByStylename("zodiac.rollingview.darkbtnball" + j);
            addChild(dark);
            dark.buttonMode = true;
            dark.mouseEnabled = false;
            dark.addEventListener("click",__ballClickHandler);
            PositionUtils.setPos(dark,"zodiac.rollingview.darkbtnball.pos" + j);
            btndarkArr.push(dark);
            j++;
         }
         if(btnShineArr == null)
         {
            btnShineArr = [];
         }
         k = 0;
         while(k < 12)
         {
            mc = ClassUtils.CreatInstance("zodiac.rollingview.notcomplete.shine");
            PositionUtils.setPos(mc,"zodiac.rollingview.btnshine.pos" + k);
            btnShineArr.push(mc);
            k++;
         }
         if(paopaoArr == null)
         {
            paopaoArr = [];
         }
         l = 0;
         while(l < 12)
         {
            paopao = ClassUtils.CreatInstance("zodiac.rollingview.ball.shine");
            PositionUtils.setPos(paopao,"zodiac.rollingview.paopao.pos" + l);
            paopaoArr.push(paopao);
            l++;
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
      
      private function __rolloverHandler(e:MouseEvent) : void
      {
         _rollingBtn.gotoAndPlay("move");
      }
      
      private function __outHandler(e:MouseEvent) : void
      {
         _rollingBtn.gotoAndPlay(1);
      }
      
      private function __rollingHandler(e:MouseEvent) : void
      {
         var frame:* = null;
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
            frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("zodiac.mainview.addCountstip",ServerConfigManager.instance.zodiacAddPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2,null,"SimpleAlert",60,false,1);
            frame.addEventListener("response",__onAlertResponse);
         }
      }
      
      private function __onAlertResponse(e:FrameEvent) : void
      {
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         frame.removeEventListener("response",__onAlertResponse);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(frame.isBand,ServerConfigManager.instance.zodiacAddPrice,onCompleteHandler);
         }
         frame.dispose();
      }
      
      private function onCompleteHandler() : void
      {
         SocketManager.Instance.out.zodiacAddCounts(CheckMoneyUtils.instance.isBind);
      }
      
      private function __ballClickHandler(e:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.play("008");
         if(ZodiacControl.instance.inRolling)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.inrolling"));
            return;
         }
         var btn:Image = e.currentTarget as Image;
         for(i = 0; i < btndarkArr.length; )
         {
            if(btndarkArr[i] == btn)
            {
               ZodiacControl.instance.setCurrentIndexView(i + 1);
            }
            i++;
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
         var i:int = 0;
         var btn:* = null;
         var qArr:Array = ZodiacModel.instance.questArr;
         for(i = 0; i < qArr.length; )
         {
            btn = btndarkArr[i] as Image;
            if(qArr[i] != 0)
            {
               btn.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               btn.mouseEnabled = true;
            }
            else
            {
               btn.filters = [];
               btn.mouseEnabled = false;
            }
            i++;
         }
      }
      
      private function refreshShineState() : void
      {
         var i:int = 0;
         var qInfo:* = null;
         var index:int = 0;
         var qArr:Array = ZodiacModel.instance.questArr;
         for(i = 0; i < qArr.length; )
         {
            if(qArr[i] != 0)
            {
               qInfo = TaskManager.instance.getQuestByID(qArr[i]);
               if((ZodiacModel.instance.awardRecord >> i + 1 & 1) == 1)
               {
                  if(btnShineArr[i].parent)
                  {
                     btnShineArr[i].parent.removeChild(btnShineArr[i]);
                  }
               }
               else if(qInfo.isAchieved)
               {
                  if(btnShineArr[i].parent)
                  {
                     btnShineArr[i].parent.removeChild(btnShineArr[i]);
                  }
               }
               else if(!(endpaopao == i + 1 && ZodiacControl.instance.inRolling == true))
               {
                  index = 0;
                  index = this.getChildIndex(finalMovie);
                  addChildAt(btnShineArr[i],index);
               }
            }
            else if(btnShineArr[i].parent)
            {
               btnShineArr[i].parent.removeChild(btnShineArr[i]);
            }
            i++;
         }
      }
      
      private function hideFinalMovie() : void
      {
         finalMovie.visible = false;
      }
      
      private function showFinalMovie(index:int) : void
      {
         PositionUtils.setPos(finalMovie,"zodiac.rollingview.finalmc.pos" + index);
         finalMovie.rotation = 300 - 30 * index;
         finalMovie.visible = true;
         finalMovie.gotoAndPlay(1);
      }
      
      private function addCurrentPaopao(index:int) : void
      {
         currentBtn = ComponentFactory.Instance.creatComponentByStylename("zodiac.rollingview.lightbtnball" + index);
         var finalindex:int = this.getChildIndex(finalMovie);
         addChildAt(currentBtn,finalindex);
         PositionUtils.setPos(currentBtn,"zodiac.rollingview.darkbtnball.pos" + index);
      }
      
      private function removeCurrentPaopao() : void
      {
         if(currentBtn != null)
         {
            removeChild(currentBtn);
            currentBtn = null;
         }
      }
      
      private function rollingComplete(index:int) : void
      {
         removeCurrentPaopao();
         addCurrentPaopao(index);
         showFinalMovie(index);
         refreshBallState();
         refreshShineState();
         ZodiacControl.instance.inRolling = false;
         ZodiacControl.instance.setCurrentIndexView(index);
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("zodiac.mainview.rollingcompletemsg"));
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.removeChildAllChildren(this);
      }
   }
}
