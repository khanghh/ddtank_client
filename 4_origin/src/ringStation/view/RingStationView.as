package ringStation.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import gameCommon.GameControl;
   import ringStation.RingStationControl;
   import road7th.comm.PackageIn;
   import trainer.view.NewHandContainer;
   
   public class RingStationView extends Frame
   {
      
      private static var CHALLENGEPERSON_NUM:int = 4;
       
      
      private var _titleBitmap:Bitmap;
      
      private var _frameBottom:ScaleBitmapImage;
      
      private var _helpBtn:BaseButton;
      
      private var _userView:StationUserView;
      
      private var _challengeVec:Vector.<ChallengePerson>;
      
      private var _arrowSrite:Sprite;
      
      private var _nameArray:Array;
      
      public function RingStationView()
      {
         _nameArray = new Array(LanguageMgr.GetTranslation("ringStation.view.person.name0"),LanguageMgr.GetTranslation("ringStation.view.person.name1"),LanguageMgr.GetTranslation("ringStation.view.person.name2"));
         super();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var challengePerson:* = null;
         titleText = LanguageMgr.GetTranslation("ddt.ringstation.titleInfo");
         _titleBitmap = ComponentFactory.Instance.creat("ringstation.view.title");
         addToContent(_titleBitmap);
         _frameBottom = ComponentFactory.Instance.creatComponentByStylename("ringstation.frameBottom");
         addToContent(_frameBottom);
         var _helpTxt:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ringStation.helpView.infoText");
         _helpTxt.text = LanguageMgr.GetTranslation("ddt.ringstation.helpInfo");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"ringStation.view.helpBtn",null,LanguageMgr.GetTranslation("ddt.ringstation.helpTitle"),_helpTxt,404,484);
         _userView = new StationUserView();
         PositionUtils.setPos(_userView,"ringStation.view.userViewPos");
         addToContent(_userView);
         _challengeVec = new Vector.<ChallengePerson>();
         for(i = 0; i < CHALLENGEPERSON_NUM; )
         {
            challengePerson = new ChallengePerson();
            PositionUtils.setPos(challengePerson,"ringStation.challenge.personPos" + i);
            addToContent(challengePerson);
            _challengeVec.push(challengePerson);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(404,1),__setViewInfo);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_1 = true;
      }
      
      private function __startLoading(e:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.sendRingStationGetInfo();
      }
      
      protected function __setViewInfo(event:PkgEvent) : void
      {
         var i:int = 0;
         var j:int = 0;
         var l:int = 0;
         var k:int = 0;
         var m:* = 0;
         var pkg:PackageIn = event.pkg;
         var rankNum:int = pkg.readInt();
         _userView.setRankNum(rankNum);
         _userView.setChallengeNum(pkg.readInt());
         _userView.buyCount = pkg.readInt();
         _userView.buyPrice = pkg.readInt();
         _userView.setChallengeTime(pkg.readDate());
         _userView.cdPrice = pkg.readInt();
         pkg.readInt();
         var sign:String = pkg.readUTF();
         _userView.setSignText(sign);
         _userView.setAwardNum(pkg.readInt());
         _userView.setAwardTime(pkg.readDate());
         _userView.setChampionText(pkg.readUTF(),pkg.readBoolean());
         _userView.setReardEnable(pkg.readBoolean());
         if(rankNum == 0)
         {
            _arrowSrite = new Sprite();
            addToContent(_arrowSrite);
            NewHandContainer.Instance.showArrow(121,45,"ringStation.view.challenge.arrowPos","","",_arrowSrite,0,true);
         }
         var count:int = pkg.readInt();
         var playerVec:Vector.<PlayerInfo> = new Vector.<PlayerInfo>();
         var rankArray:Array = [];
         for(i = 0; i < count; )
         {
            playerVec.push(readPersonInfo(pkg));
            rankArray.push(playerVec[i].Rank);
            i++;
         }
         if(count == 1 && playerVec[0].Rank == 0)
         {
            _challengeVec[0].updatePerson(playerVec[0]);
            for(j = 1; j < CHALLENGEPERSON_NUM; )
            {
               playerVec[0].NickName = _nameArray[j - 1];
               _challengeVec[j].updatePerson(playerVec[0]);
               j++;
            }
         }
         else
         {
            rankArray.sort(16);
            for(l = 0; l < rankArray.length; )
            {
               for(k = 0; k < playerVec.length; )
               {
                  if(playerVec[k].Rank == rankArray[l])
                  {
                     _challengeVec[l].updatePerson(playerVec[k]);
                  }
                  k++;
               }
               l++;
            }
            for(m = count; m < _challengeVec.length; )
            {
               _challengeVec[m].setWaiting();
               m++;
            }
         }
      }
      
      private function readPersonInfo(pkg:PackageIn) : PlayerInfo
      {
         var player:PlayerInfo = new PlayerInfo();
         player.ID = pkg.readInt();
         player.LoginName = pkg.readUTF();
         player.NickName = pkg.readUTF();
         player.typeVIP = pkg.readByte();
         player.VIPLevel = pkg.readInt();
         player.Grade = pkg.readInt();
         player.ddtKingGrade = pkg.readInt();
         player.Sex = pkg.readBoolean();
         player.Style = pkg.readUTF();
         player.Colors = pkg.readUTF();
         player.Skin = pkg.readUTF();
         player.ConsortiaName = pkg.readUTF();
         player.Hide = pkg.readInt();
         player.Offer = pkg.readInt();
         player.WinCount = pkg.readInt();
         player.TotalCount = pkg.readInt();
         player.EscapeCount = pkg.readInt();
         player.Repute = pkg.readInt();
         player.Nimbus = pkg.readInt();
         player.GP = pkg.readInt();
         player.FightPower = pkg.readInt();
         player.AchievementPoint = pkg.readInt();
         player.Rank = pkg.readInt();
         player.isAttest = pkg.readBoolean();
         player.WeaponID = pkg.readInt();
         player.signMsg = pkg.readUTF();
         return player;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(404,1),__setViewInfo);
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_8 = true;
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               RingStationControl.instance.hide();
         }
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         super.dispose();
         removeEvent();
         if(_titleBitmap)
         {
            _titleBitmap = null;
         }
         if(_frameBottom)
         {
            _frameBottom.dispose();
            _frameBottom = null;
         }
         if(_helpBtn)
         {
            _helpBtn.dispose();
            _helpBtn = null;
         }
         if(_userView)
         {
            _userView.dispose();
            _userView = null;
         }
         if(_challengeVec)
         {
            for(i = 0; i < _challengeVec.length; )
            {
               _challengeVec[i].dispose();
               _challengeVec[i] = null;
               i++;
            }
            _challengeVec.length = 0;
            _challengeVec = null;
         }
         if(_arrowSrite)
         {
            NewHandContainer.Instance.clearArrowByID(121);
            _arrowSrite = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
