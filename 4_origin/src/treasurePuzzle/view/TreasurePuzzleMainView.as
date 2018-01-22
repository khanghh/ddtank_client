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
      
      public function set currentPuzzle(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _currentPuzzle = param1;
         TreasurePuzzleManager.Instance.currentPuzzle = _currentPuzzle;
         while(_loc4_ < TreasurePuzzleManager.Instance.model.dataArr.length)
         {
            _loc3_ = TreasurePuzzleManager.Instance.model.dataArr[_loc4_];
            if(_loc3_.id == _currentPuzzle)
            {
               _loc2_ = _loc3_;
               pice1DataText.text = _loc3_.hole1Have + "/" + _loc3_.hole1Need;
               pice2DataText.text = _loc3_.hole2Have + "/" + _loc3_.hole2Need;
               pice3DataText.text = _loc3_.hole3Have + "/" + _loc3_.hole3Need;
               pice4DataText.text = _loc3_.hole4Have + "/" + _loc3_.hole4Need;
               pice5DataText.text = _loc3_.hole5Have + "/" + _loc3_.hole5Need;
               pice6DataText.text = _loc3_.hole6Have + "/" + _loc3_.hole6Need;
               if(_loc3_.hole1Have >= _loc3_.hole1Need && _loc3_.hole2Have >= _loc3_.hole2Need && _loc3_.hole3Have >= _loc3_.hole3Need && _loc3_.hole4Have >= _loc3_.hole4Need && _loc3_.hole5Have >= _loc3_.hole5Need && _loc3_.hole6Have >= _loc3_.hole6Need && !_loc3_._canGetReward)
               {
                  _getRewardBnt.enable = true;
               }
               else
               {
                  _getRewardBnt.enable = false;
               }
            }
            _loc4_++;
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
         showLightPic(_loc2_);
      }
      
      public function showLightPic(param1:TreasurePuzzlePiceData) : void
      {
         if(param1.hole1Have >= param1.hole1Need)
         {
            pic_liang1.visible = true;
         }
         else
         {
            pic_liang1.visible = false;
         }
         if(param1.hole2Have >= param1.hole2Need)
         {
            pic_liang2.visible = true;
         }
         else
         {
            pic_liang2.visible = false;
         }
         if(param1.hole3Have >= param1.hole3Need)
         {
            pic_liang3.visible = true;
         }
         else
         {
            pic_liang3.visible = false;
         }
         if(param1.hole4Have >= param1.hole4Need)
         {
            pic_liang4.visible = true;
         }
         else
         {
            pic_liang4.visible = false;
         }
         if(param1.hole5Have >= param1.hole5Need)
         {
            pic_liang5.visible = true;
         }
         else
         {
            pic_liang5.visible = false;
         }
         if(param1.hole6Have >= param1.hole6Need)
         {
            pic_liang6.visible = true;
         }
         else
         {
            pic_liang6.visible = false;
         }
      }
      
      public function getCurrentPicMap(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:String = "treasurePuzzle.view.tu" + param1;
         bg = ComponentFactory.Instance.creat(_loc3_ + "Bg");
         pic_an1 = ComponentFactory.Instance.creat(_loc3_ + "_an1");
         pic_an2 = ComponentFactory.Instance.creat(_loc3_ + "_an2");
         pic_an3 = ComponentFactory.Instance.creat(_loc3_ + "_an3");
         pic_an4 = ComponentFactory.Instance.creat(_loc3_ + "_an4");
         pic_an5 = ComponentFactory.Instance.creat(_loc3_ + "_an5");
         pic_an6 = ComponentFactory.Instance.creat(_loc3_ + "_an6");
         pic_liang1 = ComponentFactory.Instance.creat(_loc3_ + "_liang1");
         pic_liang2 = ComponentFactory.Instance.creat(_loc3_ + "_liang2");
         pic_liang3 = ComponentFactory.Instance.creat(_loc3_ + "_liang3");
         pic_liang4 = ComponentFactory.Instance.creat(_loc3_ + "_liang4");
         pic_liang5 = ComponentFactory.Instance.creat(_loc3_ + "_liang5");
         pic_liang6 = ComponentFactory.Instance.creat(_loc3_ + "_liang6");
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
         addToContent(_rightBnt);
         while(_loc5_ < TreasurePuzzleManager.Instance.model.dataArr.length)
         {
            _loc4_ = TreasurePuzzleManager.Instance.model.dataArr[_loc5_];
            if(_loc4_.id == _currentPuzzle)
            {
               _loc2_ = _loc4_;
               if(_loc4_.hole1Have == 0 && _loc4_.hole2Have == 0 && _loc4_.hole3Have == 0 && _loc4_.hole4Have == 0 && _loc4_.hole5Have == 0 && _loc4_.hole6Have == 0)
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
            _loc5_++;
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
      
      private function __clickLeftBnt(param1:MouseEvent) : void
      {
         if(_currentPuzzle - 1 < 1)
         {
            currentPuzzle = 1;
            return;
         }
         _currentPuzzle = Number(_currentPuzzle) - 1;
         currentPuzzle = _currentPuzzle;
      }
      
      private function __clickRightBnt(param1:MouseEvent) : void
      {
         if(_currentPuzzle + 1 > TreasurePuzzleManager.Instance.model.dataArr.length)
         {
            currentPuzzle = TreasurePuzzleManager.Instance.model.dataArr.length;
            return;
         }
         _currentPuzzle = Number(_currentPuzzle) + 1;
         currentPuzzle = _currentPuzzle;
      }
      
      private function __getRewardBntClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.treasurePuzzle_getReward(_currentPuzzle);
      }
      
      public function showShiwuInfoView() : void
      {
         var _loc1_:TreasurePuzzleRewardInfoView = ComponentFactory.Instance.creat("treasurePuzzle.view.rewardInfoView");
         LayerManager.Instance.addToLayer(_loc1_,0,true,1);
      }
      
      public function flushRewardBnt() : void
      {
         currentPuzzle = _currentPuzzle;
      }
      
      private function __helpBntClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.treasurePuzzle_seeReward();
      }
      
      public function showHelpView() : void
      {
         var _loc1_:TreasurePuzzleHelpView = ComponentFactory.Instance.creat("treasurePuzzle.helpView");
         LayerManager.Instance.addToLayer(_loc1_,0,true,1);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _getRewardBnt.removeEventListener("click",__getRewardBntClick);
         _helpBnt.removeEventListener("click",__helpBntClick);
         _leftBnt.removeEventListener("click",__clickLeftBnt);
         _rightBnt.removeEventListener("click",__clickRightBnt);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
