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
      
      public function HorseRacePlayerItemView(walkingPlayer:HorseRaceWalkPlayer)
      {
         super();
         _walkingPlayer = walkingPlayer;
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
         var spWidth:int = _lblName.textWidth + 8;
         _spName.graphics.beginFill(0,0.5);
         _spName.graphics.drawRoundRect(-4,0,spWidth,22,5,5);
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
      
      public function setBgVisible(bool:Boolean) : void
      {
         _selectbg.visible = bool;
      }
      
      public function flashBuffList(buffArr:Array) : void
      {
         var i:int = 0;
         var buffTIP:* = null;
         var isHavePingzhang:Boolean = false;
         _buffList.removeAllChild();
         for(i = 0; i < buffArr.length; )
         {
            if(buffArr[i] == 8)
            {
               isHavePingzhang = true;
            }
            buffTIP = getBuffByType(buffArr[i]);
            _buffList.addChild(buffTIP);
            i++;
         }
         flushRank();
         showPingzhangBuff(isHavePingzhang);
      }
      
      public function flushRank() : void
      {
         _rakeImg.gotoAndStop(_walkingPlayer.rank);
      }
      
      public function showPingzhangBuff(bool:Boolean) : void
      {
         if(bool)
         {
            _pingzhangBuff.visible = true;
         }
         else
         {
            _pingzhangBuff.visible = false;
         }
      }
      
      private function getBuffByType(type:int) : Bitmap
      {
         var buff:* = null;
         if(type == 1)
         {
            buff = ComponentFactory.Instance.creat("horseRace.raceView.buff1");
         }
         else if(type == 2)
         {
            buff = ComponentFactory.Instance.creat("horseRace.raceView.buff2");
         }
         else if(type == 3)
         {
            buff = ComponentFactory.Instance.creat("horseRace.raceView.buff3");
         }
         else if(type == 4)
         {
            buff = ComponentFactory.Instance.creat("horseRace.raceView.buff3");
         }
         else if(type == 5)
         {
            buff = ComponentFactory.Instance.creat("horseRace.raceView.buff5");
         }
         else if(type == 6)
         {
            buff = ComponentFactory.Instance.creat("horseRace.raceView.buff6");
         }
         else if(type == 7)
         {
            buff = ComponentFactory.Instance.creat("horseRace.raceView.buff7");
         }
         else if(type == 8)
         {
            buff = ComponentFactory.Instance.creat("horseRace.raceView.buff8");
         }
         buff.width = 16;
         buff.height = 16;
         return buff;
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
      
      private function headLoaderCallBack(headLoader:SceneCharacterLoaderHead, isAllLoadSucceed:Boolean = true) : void
      {
         var rectangle:* = null;
         var headBmp:* = null;
         if(headLoader)
         {
            if(!_headBitmap)
            {
               _headBitmap = new Bitmap();
            }
            rectangle = new Rectangle(0,0,HeadWidth,HeadHeight);
            headBmp = new BitmapData(HeadWidth,HeadHeight,true,0);
            headBmp.copyPixels(headLoader.getContent()[0] as BitmapData,rectangle,new Point(0,0));
            _headBitmap.bitmapData = headBmp;
            headLoader.dispose();
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
