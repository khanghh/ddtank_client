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
         var _loc3_:int = 0;
         var _loc1_:* = null;
         titleText = LanguageMgr.GetTranslation("ddt.ringstation.titleInfo");
         _titleBitmap = ComponentFactory.Instance.creat("ringstation.view.title");
         addToContent(_titleBitmap);
         _frameBottom = ComponentFactory.Instance.creatComponentByStylename("ringstation.frameBottom");
         addToContent(_frameBottom);
         var _loc2_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("ringStation.helpView.infoText");
         _loc2_.text = LanguageMgr.GetTranslation("ddt.ringstation.helpInfo");
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"ringStation.view.helpBtn",null,LanguageMgr.GetTranslation("ddt.ringstation.helpTitle"),_loc2_,404,484);
         _userView = new StationUserView();
         PositionUtils.setPos(_userView,"ringStation.view.userViewPos");
         addToContent(_userView);
         _challengeVec = new Vector.<ChallengePerson>();
         _loc3_ = 0;
         while(_loc3_ < CHALLENGEPERSON_NUM)
         {
            _loc1_ = new ChallengePerson();
            PositionUtils.setPos(_loc1_,"ringStation.challenge.personPos" + _loc3_);
            addToContent(_loc1_);
            _challengeVec.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(404,1),__setViewInfo);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         StateManager.getInGame_Step_1 = true;
      }
      
      private function __startLoading(param1:Event) : void
      {
         StateManager.getInGame_Step_6 = true;
         StateManager.setState("roomLoading",GameControl.Instance.Current);
         StateManager.getInGame_Step_7 = true;
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.sendRingStationGetInfo();
      }
      
      protected function __setViewInfo(param1:PkgEvent) : void
      {
         var _loc12_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:* = 0;
         var _loc6_:PackageIn = param1.pkg;
         var _loc5_:int = _loc6_.readInt();
         _userView.setRankNum(_loc5_);
         _userView.setChallengeNum(_loc6_.readInt());
         _userView.buyCount = _loc6_.readInt();
         _userView.buyPrice = _loc6_.readInt();
         _userView.setChallengeTime(_loc6_.readDate());
         _userView.cdPrice = _loc6_.readInt();
         _loc6_.readInt();
         var _loc3_:String = _loc6_.readUTF();
         _userView.setSignText(_loc3_);
         _userView.setAwardNum(_loc6_.readInt());
         _userView.setAwardTime(_loc6_.readDate());
         _userView.setChampionText(_loc6_.readUTF(),_loc6_.readBoolean());
         _userView.setReardEnable(_loc6_.readBoolean());
         if(_loc5_ == 0)
         {
            _arrowSrite = new Sprite();
            addToContent(_arrowSrite);
            NewHandContainer.Instance.showArrow(121,45,"ringStation.view.challenge.arrowPos","","",_arrowSrite,0,true);
         }
         var _loc4_:int = _loc6_.readInt();
         var _loc11_:Vector.<PlayerInfo> = new Vector.<PlayerInfo>();
         var _loc2_:Array = [];
         _loc12_ = 0;
         while(_loc12_ < _loc4_)
         {
            _loc11_.push(readPersonInfo(_loc6_));
            _loc2_.push(_loc11_[_loc12_].Rank);
            _loc12_++;
         }
         if(_loc4_ == 1 && _loc11_[0].Rank == 0)
         {
            _challengeVec[0].updatePerson(_loc11_[0]);
            _loc9_ = 1;
            while(_loc9_ < CHALLENGEPERSON_NUM)
            {
               _loc11_[0].NickName = _nameArray[_loc9_ - 1];
               _challengeVec[_loc9_].updatePerson(_loc11_[0]);
               _loc9_++;
            }
         }
         else
         {
            _loc2_.sort(16);
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               _loc10_ = 0;
               while(_loc10_ < _loc11_.length)
               {
                  if(_loc11_[_loc10_].Rank == _loc2_[_loc7_])
                  {
                     _challengeVec[_loc7_].updatePerson(_loc11_[_loc10_]);
                  }
                  _loc10_++;
               }
               _loc7_++;
            }
            _loc8_ = _loc4_;
            while(_loc8_ < _challengeVec.length)
            {
               _challengeVec[_loc8_].setWaiting();
               _loc8_++;
            }
         }
      }
      
      private function readPersonInfo(param1:PackageIn) : PlayerInfo
      {
         var _loc2_:PlayerInfo = new PlayerInfo();
         _loc2_.ID = param1.readInt();
         _loc2_.LoginName = param1.readUTF();
         _loc2_.NickName = param1.readUTF();
         _loc2_.typeVIP = param1.readByte();
         _loc2_.VIPLevel = param1.readInt();
         _loc2_.Grade = param1.readInt();
         _loc2_.ddtKingGrade = param1.readInt();
         _loc2_.Sex = param1.readBoolean();
         _loc2_.Style = param1.readUTF();
         _loc2_.Colors = param1.readUTF();
         _loc2_.Skin = param1.readUTF();
         _loc2_.ConsortiaName = param1.readUTF();
         _loc2_.Hide = param1.readInt();
         _loc2_.Offer = param1.readInt();
         _loc2_.WinCount = param1.readInt();
         _loc2_.TotalCount = param1.readInt();
         _loc2_.EscapeCount = param1.readInt();
         _loc2_.Repute = param1.readInt();
         _loc2_.Nimbus = param1.readInt();
         _loc2_.GP = param1.readInt();
         _loc2_.FightPower = param1.readInt();
         _loc2_.AchievementPoint = param1.readInt();
         _loc2_.Rank = param1.readInt();
         _loc2_.isAttest = param1.readBoolean();
         _loc2_.WeaponID = param1.readInt();
         _loc2_.signMsg = param1.readUTF();
         return _loc2_;
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
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               RingStationControl.instance.hide();
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
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
            _loc1_ = 0;
            while(_loc1_ < _challengeVec.length)
            {
               _challengeVec[_loc1_].dispose();
               _challengeVec[_loc1_] = null;
               _loc1_++;
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
