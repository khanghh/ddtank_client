package treasurePuzzle.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import treasurePuzzle.controller.TreasurePuzzleManager;
   import treasurePuzzle.data.TreasurePuzzlePiceData;
   
   public class TreasurePuzzleMainView extends Frame
   {
       
      
      private var _topBg:Bitmap;
      
      private var _downBg:Bitmap;
      
      private var _getRewardBnt:BaseButton;
      
      private var _helpBnt:BaseButton;
      
      private var _leftBnt:BaseButton;
      
      private var _rightBnt:BaseButton;
      
      private var _currentPuzzle:int;
      
      private var pice1DataText:FilterFrameText;
      
      private var pice2DataText:FilterFrameText;
      
      private var pice3DataText:FilterFrameText;
      
      private var pice4DataText:FilterFrameText;
      
      private var pice5DataText:FilterFrameText;
      
      private var pice6DataText:FilterFrameText;
      
      private var bg:Bitmap;
      
      private var pic_an1:Bitmap;
      
      private var pic_an2:Bitmap;
      
      private var pic_an3:Bitmap;
      
      private var pic_an4:Bitmap;
      
      private var pic_an5:Bitmap;
      
      private var pic_an6:Bitmap;
      
      private var pic_liang1:Bitmap;
      
      private var pic_liang2:Bitmap;
      
      private var pic_liang3:Bitmap;
      
      private var pic_liang4:Bitmap;
      
      private var pic_liang5:Bitmap;
      
      private var pic_liang6:Bitmap;
      
      public function TreasurePuzzleMainView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _topBg = ComponentFactory.Instance.creat("treasurePuzzle.topBg");
         _downBg = ComponentFactory.Instance.creat("treasurePuzzle.downBg");
         _getRewardBnt = ComponentFactory.Instance.creat("treasurePuzzle.getRewardBnt");
         _helpBnt = ComponentFactory.Instance.creat("treasurePuzzle.helpBnt");
         _leftBnt = ComponentFactory.Instance.creat("treasurePuzzle.leftBnt");
         _rightBnt = ComponentFactory.Instance.creat("treasurePuzzle.rightBnt");
         pice1DataText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.mainView.piceDataContentText");
         pice2DataText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.mainView.piceDataContentText");
         pice3DataText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.mainView.piceDataContentText");
         pice4DataText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.mainView.piceDataContentText");
         pice5DataText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.mainView.piceDataContentText");
         pice6DataText = ComponentFactory.Instance.creatComponentByStylename("treasurePuzzle.mainView.piceDataContentText");
         PositionUtils.setPos(pice1DataText,"treasurePuzzle.mainView.pice1DataTextPos");
         PositionUtils.setPos(pice2DataText,"treasurePuzzle.mainView.pice2DataTextPos");
         PositionUtils.setPos(pice3DataText,"treasurePuzzle.mainView.pice3DataTextPos");
         PositionUtils.setPos(pice4DataText,"treasurePuzzle.mainView.pice4DataTextPos");
         PositionUtils.setPos(pice5DataText,"treasurePuzzle.mainView.pice5DataTextPos");
         PositionUtils.setPos(pice6DataText,"treasurePuzzle.mainView.pice6DataTextPos");
         currentPuzzle = 1;
         addToContent(_downBg);
         addToContent(_topBg);
         addToContent(_getRewardBnt);
         addToContent(_helpBnt);
      }
      
      public function set currentPuzzle(id:int) : void
      {
         var currentPuzzleData:* = null;
         var i:int = 0;
         var data:* = null;
         _currentPuzzle = id;
         for(TreasurePuzzleManager.Instance.currentPuzzle = _currentPuzzle; i < TreasurePuzzleManager.Instance.model.dataArr.length; )
         {
            data = TreasurePuzzleManager.Instance.model.dataArr[i];
            if(data.id == _currentPuzzle)
            {
               currentPuzzleData = data;
               pice1DataText.text = data.hole1Have + "/" + data.hole1Need;
               pice2DataText.text = data.hole2Have + "/" + data.hole2Need;
               pice3DataText.text = data.hole3Have + "/" + data.hole3Need;
               pice4DataText.text = data.hole4Have + "/" + data.hole4Need;
               pice5DataText.text = data.hole5Have + "/" + data.hole5Need;
               pice6DataText.text = data.hole6Have + "/" + data.hole6Need;
               if(data.hole1Have >= data.hole1Need && data.hole2Have >= data.hole2Need && data.hole3Have >= data.hole3Need && data.hole4Have >= data.hole4Need && data.hole5Have >= data.hole5Need && data.hole6Have >= data.hole6Need && !data._canGetReward)
               {
                  _getRewardBnt.enable = true;
               }
               else
               {
                  _getRewardBnt.enable = false;
               }
            }
            i++;
         }
         if(_currentPuzzle == 1)
         {
            _leftBnt.enable = false;
            _rightBnt.enable = true;
         }
         else if(_currentPuzzle == TreasurePuzzleManager.Instance.model.dataArr.length)
         {
            _rightBnt.enable = false;
            _leftBnt.enable = true;
         }
         else
         {
            _leftBnt.enable = true;
            _rightBnt.enable = true;
         }
         getCurrentPicMap(_currentPuzzle);
         showLightPic(currentPuzzleData);
      }
      
      public function showLightPic(data:TreasurePuzzlePiceData) : void
      {
         if(data.hole1Have >= data.hole1Need)
         {
            pic_liang1.visible = true;
         }
         else
         {
            pic_liang1.visible = false;
         }
         if(data.hole2Have >= data.hole2Need)
         {
            pic_liang2.visible = true;
         }
         else
         {
            pic_liang2.visible = false;
         }
         if(data.hole3Have >= data.hole3Need)
         {
            pic_liang3.visible = true;
         }
         else
         {
            pic_liang3.visible = false;
         }
         if(data.hole4Have >= data.hole4Need)
         {
            pic_liang4.visible = true;
         }
         else
         {
            pic_liang4.visible = false;
         }
         if(data.hole5Have >= data.hole5Need)
         {
            pic_liang5.visible = true;
         }
         else
         {
            pic_liang5.visible = false;
         }
         if(data.hole6Have >= data.hole6Need)
         {
            pic_liang6.visible = true;
         }
         else
         {
            pic_liang6.visible = false;
         }
      }
      
      public function getCurrentPicMap(id:int) : void
      {
         var currentPuzzleData:* = null;
         var i:int = 0;
         var data:* = null;
         var str:String = "treasurePuzzle.view.tu" + id;
         bg = ComponentFactory.Instance.creat(str + "Bg");
         pic_an1 = ComponentFactory.Instance.creat(str + "_an1");
         pic_an2 = ComponentFactory.Instance.creat(str + "_an2");
         pic_an3 = ComponentFactory.Instance.creat(str + "_an3");
         pic_an4 = ComponentFactory.Instance.creat(str + "_an4");
         pic_an5 = ComponentFactory.Instance.creat(str + "_an5");
         pic_an6 = ComponentFactory.Instance.creat(str + "_an6");
         pic_liang1 = ComponentFactory.Instance.creat(str + "_liang1");
         pic_liang2 = ComponentFactory.Instance.creat(str + "_liang2");
         pic_liang3 = ComponentFactory.Instance.creat(str + "_liang3");
         pic_liang4 = ComponentFactory.Instance.creat(str + "_liang4");
         pic_liang5 = ComponentFactory.Instance.creat(str + "_liang5");
         pic_liang6 = ComponentFactory.Instance.creat(str + "_liang6");
         PositionUtils.setPos(bg,"treasurePuzzle.view.tuBgPos");
         PositionUtils.setPos(pic_an1,"treasurePuzzle.view.tu_an1Pos");
         PositionUtils.setPos(pic_an2,"treasurePuzzle.view.tu_an2Pos");
         PositionUtils.setPos(pic_an3,"treasurePuzzle.view.tu_an3Pos");
         PositionUtils.setPos(pic_an4,"treasurePuzzle.view.tu_an4Pos");
         PositionUtils.setPos(pic_an5,"treasurePuzzle.view.tu_an5Pos");
         PositionUtils.setPos(pic_an6,"treasurePuzzle.view.tu_an6Pos");
         PositionUtils.setPos(pic_liang1,"treasurePuzzle.view.tu_liang1Pos");
         PositionUtils.setPos(pic_liang2,"treasurePuzzle.view.tu_liang2Pos");
         PositionUtils.setPos(pic_liang3,"treasurePuzzle.view.tu_liang3Pos");
         PositionUtils.setPos(pic_liang4,"treasurePuzzle.view.tu_liang4Pos");
         PositionUtils.setPos(pic_liang5,"treasurePuzzle.view.tu_liang5Pos");
         PositionUtils.setPos(pic_liang6,"treasurePuzzle.view.tu_liang6Pos");
         addToContent(bg);
         addToContent(pic_an1);
         addToContent(pic_an2);
         addToContent(pic_an3);
         addToContent(pic_an4);
         addToContent(pic_an5);
         addToContent(pic_an6);
         addToContent(pic_liang1);
         addToContent(pic_liang2);
         addToContent(pic_liang3);
         addToContent(pic_liang4);
         addToContent(pic_liang5);
         addToContent(pic_liang6);
         addToContent(pice1DataText);
         addToContent(pice2DataText);
         addToContent(pice3DataText);
         addToContent(pice4DataText);
         addToContent(pice5DataText);
         addToContent(pice6DataText);
         addToContent(_leftBnt);
         for(addToContent(_rightBnt); i < TreasurePuzzleManager.Instance.model.dataArr.length; )
         {
            data = TreasurePuzzleManager.Instance.model.dataArr[i];
            if(data.id == _currentPuzzle)
            {
               currentPuzzleData = data;
               if(data.hole1Have == 0 && data.hole2Have == 0 && data.hole3Have == 0 && data.hole4Have == 0 && data.hole5Have == 0 && data.hole6Have == 0)
               {
                  pic_an1.visible = false;
                  pic_an2.visible = false;
                  pic_an3.visible = false;
                  pic_an4.visible = false;
                  pic_an5.visible = false;
                  pic_an6.visible = false;
               }
               else
               {
                  pic_an1.visible = true;
                  pic_an2.visible = true;
                  pic_an3.visible = true;
                  pic_an4.visible = true;
                  pic_an5.visible = true;
                  pic_an6.visible = true;
               }
            }
            i++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _getRewardBnt.addEventListener("click",__getRewardBntClick);
         _helpBnt.addEventListener("click",__helpBntClick);
         _leftBnt.addEventListener("click",__clickLeftBnt);
         _rightBnt.addEventListener("click",__clickRightBnt);
      }
      
      private function __clickLeftBnt(e:MouseEvent) : void
      {
         if(_currentPuzzle - 1 < 1)
         {
            currentPuzzle = 1;
            return;
         }
         _currentPuzzle = Number(_currentPuzzle) - 1;
         currentPuzzle = _currentPuzzle;
      }
      
      private function __clickRightBnt(e:MouseEvent) : void
      {
         if(_currentPuzzle + 1 > TreasurePuzzleManager.Instance.model.dataArr.length)
         {
            currentPuzzle = TreasurePuzzleManager.Instance.model.dataArr.length;
            return;
         }
         _currentPuzzle = Number(_currentPuzzle) + 1;
         currentPuzzle = _currentPuzzle;
      }
      
      private function __getRewardBntClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.treasurePuzzle_getReward(_currentPuzzle);
      }
      
      public function showShiwuInfoView() : void
      {
         var rewardInfoView:TreasurePuzzleRewardInfoView = ComponentFactory.Instance.creat("treasurePuzzle.view.rewardInfoView");
         LayerManager.Instance.addToLayer(rewardInfoView,0,true,1);
      }
      
      public function flushRewardBnt() : void
      {
         currentPuzzle = _currentPuzzle;
      }
      
      private function __helpBntClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.treasurePuzzle_seeReward();
      }
      
      public function showHelpView() : void
      {
         var helpView:TreasurePuzzleHelpView = ComponentFactory.Instance.creat("treasurePuzzle.helpView");
         LayerManager.Instance.addToLayer(helpView,0,true,1);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _getRewardBnt.removeEventListener("click",__getRewardBntClick);
         _helpBnt.removeEventListener("click",__helpBntClick);
         _leftBnt.removeEventListener("click",__clickLeftBnt);
         _rightBnt.removeEventListener("click",__clickRightBnt);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               TreasurePuzzleManager.Instance.hide();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_topBg)
         {
            _topBg.bitmapData.dispose();
            _topBg = null;
         }
         if(_downBg)
         {
            _downBg.bitmapData.dispose();
            _downBg = null;
         }
         if(_getRewardBnt)
         {
            _getRewardBnt.dispose();
            _getRewardBnt = null;
         }
         if(_helpBnt)
         {
            _helpBnt.dispose();
            _helpBnt = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
   }
}
