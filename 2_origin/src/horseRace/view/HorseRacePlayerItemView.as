package horseRace.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterLoaderHead;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HorseRacePlayerItemView extends Sprite implements Disposeable
   {
      
      private static var HeadWidth:int = 120;
      
      private static var HeadHeight:int = 103;
       
      
      private var _selectbg:Bitmap;
      
      private var _isSelf:Boolean;
      
      private var _headBg:Bitmap;
      
      private var _rakeImg:MovieClip;
      
      private var _playerNameTxt:FilterFrameText;
      
      private var _spName:Sprite;
      
      private var _lblName:FilterFrameText;
      
      private var _walkingPlayer:HorseRaceWalkPlayer;
      
      private var _headLoader:SceneCharacterLoaderHead;
      
      private var _headBitmap:Bitmap;
      
      private var _clickSp:Sprite;
      
      private var _buffList:HBox;
      
      private var _pingzhangBuff:MovieClip;
      
      public function HorseRacePlayerItemView(param1:HorseRaceWalkPlayer)
      {
         super();
         _walkingPlayer = param1;
         initView();
         loadHead();
         initEvent();
      }
      
      public function getPlayerInfo() : HorseRaceWalkPlayer
      {
         return _walkingPlayer;
      }
      
      private function initView() : void
      {
         _selectbg = ComponentFactory.Instance.creat("horseRace.raceView.playerItemSelectBg");
         _spName = new Sprite();
         _lblName = ComponentFactory.Instance.creat("asset.hall.playerInfo.lblName");
         _lblName.mouseEnabled = false;
         _lblName.text = _walkingPlayer.playerVO.playerInfo.NickName;
         var _loc1_:int = _lblName.textWidth + 8;
         _spName.graphics.beginFill(0,0.5);
         _spName.graphics.drawRoundRect(-4,0,_loc1_,22,5,5);
         _spName.graphics.endFill();
         _spName.addChild(_lblName);
         PositionUtils.setPos(_spName,"horseRace.raceView.playerItemNamePos");
         _rakeImg = ComponentFactory.Instance.creat("horseRace.raceView.playerRaceMc");
         PositionUtils.setPos(_rakeImg,"horseRace.raceView.playerRankPos");
         if(_walkingPlayer.isSelf)
         {
            _headBg = ComponentFactory.Instance.creat("horseRace.raceView.selfplayerBg");
         }
         else
         {
            _headBg = ComponentFactory.Instance.creat("horseRace.raceView.otherplayerBg");
         }
         _clickSp = new Sprite();
         _clickSp.x = _selectbg.x;
         _clickSp.y = _selectbg.y;
         _clickSp.graphics.beginFill(0,0);
         _clickSp.graphics.drawRect(0,0,_selectbg.width,_selectbg.height);
         _clickSp.graphics.endFill();
         addChild(_clickSp);
         addChild(_selectbg);
         _selectbg.visible = false;
         _buffList = ComponentFactory.Instance.creatComponentByStylename("horseRace.raceView.buffList");
         addChild(_buffList);
         _pingzhangBuff = ComponentFactory.Instance.creat("horseRaceView.pingzhangHaveBuff");
         PositionUtils.setPos(_pingzhangBuff,"horseRace.raceView.pingzhangBuffPos");
      }
      
      public function setBgVisible(param1:Boolean) : void
      {
         _selectbg.visible = param1;
      }
      
      public function flashBuffList(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Boolean = false;
         _buffList.removeAllChild();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] == 8)
            {
               _loc2_ = true;
            }
            _loc3_ = getBuffByType(param1[_loc4_]);
            _buffList.addChild(_loc3_);
            _loc4_++;
         }
         flushRank();
         showPingzhangBuff(_loc2_);
      }
      
      public function flushRank() : void
      {
         _rakeImg.gotoAndStop(_walkingPlayer.rank);
      }
      
      public function showPingzhangBuff(param1:Boolean) : void
      {
         if(param1)
         {
            _pingzhangBuff.visible = true;
         }
         else
         {
            _pingzhangBuff.visible = false;
         }
      }
      
      private function getBuffByType(param1:int) : Bitmap
      {
         var _loc2_:* = null;
         if(param1 == 1)
         {
            _loc2_ = ComponentFactory.Instance.creat("horseRace.raceView.buff1");
         }
         else if(param1 == 2)
         {
            _loc2_ = ComponentFactory.Instance.creat("horseRace.raceView.buff2");
         }
         else if(param1 == 3)
         {
            _loc2_ = ComponentFactory.Instance.creat("horseRace.raceView.buff3");
         }
         else if(param1 == 4)
         {
            _loc2_ = ComponentFactory.Instance.creat("horseRace.raceView.buff3");
         }
         else if(param1 == 5)
         {
            _loc2_ = ComponentFactory.Instance.creat("horseRace.raceView.buff5");
         }
         else if(param1 == 6)
         {
            _loc2_ = ComponentFactory.Instance.creat("horseRace.raceView.buff6");
         }
         else if(param1 == 7)
         {
            _loc2_ = ComponentFactory.Instance.creat("horseRace.raceView.buff7");
         }
         else if(param1 == 8)
         {
            _loc2_ = ComponentFactory.Instance.creat("horseRace.raceView.buff8");
         }
         _loc2_.width = 16;
         _loc2_.height = 16;
         return _loc2_;
      }
      
      public function loadHead() : void
      {
         if(_headLoader)
         {
            _headLoader.dispose();
            _headLoader = null;
         }
         _headLoader = new SceneCharacterLoaderHead(_walkingPlayer.playerVO.playerInfo);
         _headLoader.load(headLoaderCallBack);
      }
      
      private function headLoaderCallBack(param1:SceneCharacterLoaderHead, param2:Boolean = true) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1)
         {
            if(!_headBitmap)
            {
               _headBitmap = new Bitmap();
            }
            _loc3_ = new Rectangle(0,0,HeadWidth,HeadHeight);
            _loc4_ = new BitmapData(HeadWidth,HeadHeight,true,0);
            _loc4_.copyPixels(param1.getContent()[0] as BitmapData,_loc3_,new Point(0,0));
            _headBitmap.bitmapData = _loc4_;
            param1.dispose();
            _headBitmap.rotationY = 180;
            if(_walkingPlayer.isSelf)
            {
               _headBitmap.width = 62;
               _headBitmap.height = 52;
               PositionUtils.setPos(_headBitmap,"horseRace.raceView.playerSelfImgPos");
            }
            else
            {
               _headBitmap.width = 52;
               _headBitmap.height = 42;
               PositionUtils.setPos(_headBitmap,"horseRace.raceView.playerOtherImgPos");
            }
            _rakeImg.gotoAndStop(_walkingPlayer.rank);
            addChild(_spName);
            addChild(_headBg);
            addChild(_headBitmap);
            addChild(_rakeImg);
            addChild(_pingzhangBuff);
            showPingzhangBuff(false);
         }
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
