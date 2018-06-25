package DDPlay
{
   import baglocked.BaglockedManager;
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import com.greensock.easing.Linear;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.BagEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import invite.InviteManager;
   import road7th.comm.PackageIn;
   
   public class DDPlayView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _boguTypePoints:Array;
      
      private var _sixBogu1:MovieClip;
      
      private var _sixBogu2:MovieClip;
      
      private var _sixBogu3:MovieClip;
      
      private var _boguMaskSp1:MovieClip;
      
      private var _boguMaskSp2:MovieClip;
      
      private var _boguMaskSp3:MovieClip;
      
      private var _boguMask1:MovieClip;
      
      private var _boguMask2:MovieClip;
      
      private var _boguMask3:MovieClip;
      
      private var _tripleMc:MovieClip;
      
      private var _fivefoldMc:MovieClip;
      
      private var _tenfoldMc:MovieClip;
      
      private var _triple:Bitmap;
      
      private var _fivefold:Bitmap;
      
      private var _tenfold:Bitmap;
      
      private var _lights:MovieClip;
      
      private var _shine1:MovieClip;
      
      private var _shine2:MovieClip;
      
      private var _shine3:MovieClip;
      
      private var _titleLight:MovieClip;
      
      private var _finallyLight:MovieClip;
      
      private var _finallyFireWork:MovieClip;
      
      private var _upBtn:SimpleBitmapButton;
      
      private var _stopUpBtn:SimpleBitmapButton;
      
      private var _selectedTxt:SelectedCheckButton;
      
      private var _exchangeBtn:BaseButton;
      
      private var timer:Timer;
      
      private var _explameTxt:FilterFrameText;
      
      private var _coinsTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _exchangeFrame:DDPlayExchangeFrame;
      
      private var isPlaying:Boolean;
      
      private var _multiple:int;
      
      private var tw1:TweenLite;
      
      private var tw2:TweenLite;
      
      private var tw3:TweenLite;
      
      private const fastest:Number = 0.3;
      
      private const startSpeed:Number = 0.4;
      
      private const tempSpeed:Number = 0.05;
      
      private var fastestLast1:int = 3;
      
      private var fastestLast2:int = 5;
      
      private var fastestLast3:int = 8;
      
      private var tSpeed1:Number = 0.4;
      
      private var tSpeed2:Number = 0.4;
      
      private var tSpeed3:Number = 0.4;
      
      public function DDPlayView()
      {
         timer = new Timer(5000);
         super();
         initView();
         initEvent();
         sendPkg();
      }
      
      private function initView() : void
      {
         InviteManager.Instance.enabled = false;
         _boguTypePoints = [];
         var _loc1_:* = new Point();
         _boguTypePoints[0] = _loc1_;
         PositionUtils.setPos(_loc1_,"DDPlay.view.2Bogu2");
         _loc1_ = new Point();
         _boguTypePoints[1] = _loc1_;
         PositionUtils.setPos(_loc1_,"DDPlay.view.1Bogu1");
         _loc1_ = new Point();
         _boguTypePoints[2] = _loc1_;
         PositionUtils.setPos(_loc1_,"DDPlay.view.2Bogu1");
         _loc1_ = new Point();
         _boguTypePoints[3] = _loc1_;
         PositionUtils.setPos(_loc1_,"DDPlay.view.3Bogu1");
         _bg = ComponentFactory.Instance.creat("DDPlay.view.bg");
         _sixBogu1 = ClassUtils.CreatInstance("DDPlay.view.sixBoguMc");
         _sixBogu2 = ClassUtils.CreatInstance("DDPlay.view.sixBoguMc");
         _sixBogu3 = ClassUtils.CreatInstance("DDPlay.view.sixBoguMc");
         _boguMask1 = ClassUtils.CreatInstance("DDPlay.view.mask");
         _boguMask2 = ClassUtils.CreatInstance("DDPlay.view.mask");
         _boguMask3 = ClassUtils.CreatInstance("DDPlay.view.mask");
         _boguMaskSp1 = ClassUtils.CreatInstance("DDPlay.view.mask");
         _boguMaskSp2 = ClassUtils.CreatInstance("DDPlay.view.mask");
         _boguMaskSp3 = ClassUtils.CreatInstance("DDPlay.view.mask");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("DDPlay.view.upBtn");
         _stopUpBtn = ComponentFactory.Instance.creatComponentByStylename("DDPlay.view.stopUpBtn");
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("DDPlay.view.exchangeBaseBtn");
         _selectedTxt = ComponentFactory.Instance.creat("DDPlay.view.SelectedCheckButton");
         _explameTxt = ComponentFactory.Instance.creatComponentByStylename("DDPlay.view.explameTxt");
         _coinsTxt = ComponentFactory.Instance.creatComponentByStylename("DDPlay.view.coinsTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("DDPlay.view.scoreTxt");
         _explameTxt.htmlText = LanguageMgr.GetTranslation("tank.ddPlay.view.explame");
         _scoreTxt.text = DDPlayManaer.Instance.DDPlayScore.toString();
         _coinsTxt.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201310).toString();
         _tripleMc = ClassUtils.CreatInstance("DDPlay.view.tripleMc");
         _fivefoldMc = ClassUtils.CreatInstance("DDPlay.view.fiveFoldMc");
         _tenfoldMc = ClassUtils.CreatInstance("DDPlay.view.tenFoldMc");
         _triple = ComponentFactory.Instance.creatBitmap("DDPlay.view.triple");
         _fivefold = ComponentFactory.Instance.creatBitmap("DDPlay.view.fiveFold");
         _tenfold = ComponentFactory.Instance.creatBitmap("DDPlay.view.tenFold");
         _lights = ClassUtils.CreatInstance("DDPlay.view.bulbsMc");
         _shine1 = ClassUtils.CreatInstance("DDPlay.view.boguYellowShineMc");
         _shine2 = ClassUtils.CreatInstance("DDPlay.view.boguYellowShineMc");
         _shine3 = ClassUtils.CreatInstance("DDPlay.view.boguYellowShineMc");
         _titleLight = ClassUtils.CreatInstance("DDPlay.view.lightMc");
         _finallyLight = ClassUtils.CreatInstance("DDPlay.view.lastMc");
         _finallyFireWork = ClassUtils.CreatInstance("DDPlay.view.fireWorkMc");
         addToContent(_bg);
         addToContent(_sixBogu1);
         _sixBogu1.mask = _boguMaskSp1;
         _sixBogu1.y = _boguTypePoints[1].y;
         addToContent(_boguMaskSp1);
         addToContent(_sixBogu2);
         _sixBogu2.mask = _boguMaskSp2;
         _sixBogu2.y = _boguTypePoints[2].y;
         addToContent(_boguMaskSp2);
         addToContent(_sixBogu3);
         _sixBogu3.mask = _boguMaskSp3;
         _sixBogu3.y = _boguTypePoints[3].y;
         addToContent(_boguMaskSp3);
         addToContent(_explameTxt);
         addToContent(_coinsTxt);
         addToContent(_scoreTxt);
         PositionUtils.setPos(_sixBogu1,"DDPlay.view.sixBogu1");
         PositionUtils.setPos(_sixBogu2,"DDPlay.view.sixBogu2");
         PositionUtils.setPos(_sixBogu3,"DDPlay.view.sixBogu3");
         PositionUtils.setPos(_boguMaskSp1,"DDPlay.view.maskPos1");
         PositionUtils.setPos(_boguMaskSp2,"DDPlay.view.maskPos2");
         PositionUtils.setPos(_boguMaskSp3,"DDPlay.view.maskPos3");
         addToContent(_boguMask1);
         addToContent(_boguMask2);
         addToContent(_boguMask3);
         PositionUtils.setPos(_boguMask1,"DDPlay.view.maskPos1");
         PositionUtils.setPos(_boguMask2,"DDPlay.view.maskPos2");
         PositionUtils.setPos(_boguMask3,"DDPlay.view.maskPos3");
         addToContent(_triple);
         addToContent(_fivefold);
         addToContent(_tenfold);
         addToContent(_tripleMc);
         addToContent(_fivefoldMc);
         addToContent(_tenfoldMc);
         _loc1_ = false;
         _tenfoldMc.visible = _loc1_;
         _loc1_ = _loc1_;
         _fivefoldMc.visible = _loc1_;
         _tripleMc.visible = _loc1_;
         addToContent(_lights);
         addToContent(_shine1);
         addToContent(_shine2);
         addToContent(_shine3);
         _shine1.gotoAndStop(1);
         _shine2.gotoAndStop(1);
         _shine3.gotoAndStop(1);
         _loc1_ = false;
         _shine3.visible = _loc1_;
         _loc1_ = _loc1_;
         _shine2.visible = _loc1_;
         _shine1.visible = _loc1_;
         addToContent(_titleLight);
         PositionUtils.setPos(_tripleMc,"DDPlay.view.tripleMc");
         PositionUtils.setPos(_fivefoldMc,"DDPlay.view.fivefoldMc");
         PositionUtils.setPos(_tenfoldMc,"DDPlay.view.temfoldMc");
         PositionUtils.setPos(_lights,"DDPlay.view.lights");
         PositionUtils.setPos(_shine1,"DDPlay.view.shine1");
         PositionUtils.setPos(_shine2,"DDPlay.view.shine2");
         PositionUtils.setPos(_shine3,"DDPlay.view.shine3");
         PositionUtils.setPos(_titleLight,"DDPlay.view.titlelight");
         PositionUtils.setPos(_finallyLight,"DDPlay.view.finallyLight");
         PositionUtils.setPos(_finallyFireWork,"DDPlay.view.finallyLight");
         addToContent(_upBtn);
         addToContent(_stopUpBtn);
         addToContent(_selectedTxt);
         addToContent(_exchangeBtn);
         _stopUpBtn.visible = false;
         addToContent(_finallyLight);
         _finallyLight.visible = false;
         addToContent(_finallyFireWork);
         _finallyFireWork.visible = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__response);
         _upBtn.addEventListener("click",doUpHonor,false,0,true);
         _stopUpBtn.addEventListener("click",stopDoUpHonor,false,0,true);
         _selectedTxt.addEventListener("click",__checkBoxClick);
         _exchangeBtn.addEventListener("click",__scoreExchange);
         timer.addEventListener("timer",_timerHandler);
         DDPlayManaer.Instance.addEventListener("DDPlay_enter",__updateScore);
         DDPlayManaer.Instance.addEventListener("DDPlay_start",__start);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",_bagUpdate);
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.DDPlayEnter();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__response);
         _upBtn.removeEventListener("click",doUpHonor);
         _stopUpBtn.removeEventListener("click",stopDoUpHonor);
         _selectedTxt.removeEventListener("click",__checkBoxClick);
         _exchangeBtn.removeEventListener("click",__scoreExchange);
         timer.removeEventListener("timer",_timerHandler);
         DDPlayManaer.Instance.removeEventListener("DDPlay_enter",__updateScore);
         DDPlayManaer.Instance.removeEventListener("DDPlay_start",__start);
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",_bagUpdate);
      }
      
      private function __updateScore(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         DDPlayManaer.Instance.DDPlayScore = pkg.readInt();
         _scoreTxt.text = DDPlayManaer.Instance.DDPlayScore.toString();
         _coinsTxt.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201310).toString();
         DDPlayManaer.Instance.dispatchEvent(new Event("update_score"));
      }
      
      private function __start(e:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         _multiple = pkg.readInt();
         DDPlayManaer.Instance.DDPlayScore = pkg.readInt();
         refreshShow();
      }
      
      private function _timerHandler(e:TimerEvent) : void
      {
         if(DDPlayManaer.Instance.isOpen == false)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.ddPlay.end"));
            return;
         }
         if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201310) < 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.ddPlay.view.LeBiNotEnough"));
            timer.stop();
            _stopUpBtn.visible = false;
            _upBtn.enable = true;
            _selectedTxt.enable = true;
            isPlaying = false;
            return;
         }
         isPlaying = true;
         SocketManager.Instance.out.DDPlayStart();
      }
      
      private function __response(e:FrameEvent) : void
      {
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            SoundManager.instance.play("008");
            if(_upBtn.enable == false)
            {
               return;
            }
            dispatchEvent(new Event("close"));
            dispose();
         }
      }
      
      private function _bagUpdate(e:BagEvent) : void
      {
         _coinsTxt.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201310).toString();
      }
      
      private function __scoreExchange(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(DDPlayManaer.Instance.isOpen == false)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.ddPlay.end"));
            return;
         }
         if(_upBtn.enable == false)
         {
            return;
         }
         _exchangeFrame = ComponentFactory.Instance.creatComponentByStylename("DDPlay.exchange.frame");
         LayerManager.Instance.addToLayer(_exchangeFrame,3,true,1);
      }
      
      private function doUpHonor(event:MouseEvent) : void
      {
         var quick:* = null;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(DDPlayManaer.Instance.isOpen == false)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.ddPlay.end"));
            return;
         }
         if(PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201310) < 1)
         {
            quick = ComponentFactory.Instance.creatCustomObject("DDPlay.quickBuyCoins.frame");
            quick.show(0);
            return;
         }
         if(_selectedTxt.selected)
         {
            _stopUpBtn.visible = true;
            timer.reset();
            timer.start();
         }
         _upBtn.enable = false;
         _selectedTxt.enable = false;
         isPlaying = true;
         SocketManager.Instance.out.DDPlayStart();
      }
      
      private function stopDoUpHonor(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         timer.stop();
         _stopUpBtn.visible = false;
         if(isPlaying == false)
         {
            _upBtn.enable = true;
            _selectedTxt.enable = true;
         }
      }
      
      private function __checkBoxClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function refreshShow() : void
      {
         var lm:int = 0;
         var a1:* = 0;
         var a2:int = 0;
         var a3:int = 0;
         var b1:int = 0;
         var b2:int = 0;
         var b3:int = 0;
         if(1)
         {
            lm = _multiple;
            switch(int(lm) - 2)
            {
               case 0:
                  a1 = int(Math.ceil(Math.random() * 3));
                  a2 = Math.ceil(Math.random() * 3);
                  a3 = Math.ceil(Math.random() * 3);
                  if(a1 == a2 && a2 == a3)
                  {
                     if(a2 == 1)
                     {
                        a2 = 2;
                     }
                     else if(a2 == 2)
                     {
                        a2 = 3;
                     }
                     else
                     {
                        a2 = 1;
                     }
                  }
                  if(a1 != a2 && a1 != a3 && a2 != a3)
                  {
                     a1 = a2;
                  }
                  startLottery(a1,a2,a3);
                  break;
               case 1:
                  startLottery(1,1,1);
                  break;
               default:
                  b1 = Math.ceil(Math.random() * 3);
                  b2 = Math.ceil(Math.random() * 3);
                  b3 = Math.ceil(Math.random() * 3);
                  if(b1 == b2)
                  {
                     if(b2 == 1)
                     {
                        b2 = 2;
                     }
                     else if(b2 == 2)
                     {
                        b2 = 3;
                     }
                     else
                     {
                        b2 = 1;
                     }
                  }
                  if(b3 == b2 || b3 == b1)
                  {
                     if(b1 + b2 == 3)
                     {
                        b3 = 3;
                     }
                     else if(b1 + b2 == 4)
                     {
                        b3 = 2;
                     }
                     else
                     {
                        b3 = 1;
                     }
                  }
                  startLottery(b1,b2,b3);
                  break;
               case 3:
               default:
               default:
               default:
               default:
                  startLottery(2,2,2);
                  break;
               case 8:
                  startLottery(3,3,3);
            }
         }
      }
      
      private function startLottery(bg1:int = 1, bg2:int = 2, bg3:int = 3) : void
      {
         reSetBogu();
         tw1 = TweenLite.to(_sixBogu1,(_sixBogu1.y - _boguTypePoints[2].y) / 375,{
            "y":_boguTypePoints[2].y,
            "ease":Linear.easeNone,
            "onComplete":_sixBogu1Com,
            "onCompleteParams":[bg1]
         });
         tw2 = TweenLite.to(_sixBogu2,(_sixBogu2.y - _boguTypePoints[2].y) / 375,{
            "y":_boguTypePoints[2].y,
            "ease":Linear.easeNone,
            "onComplete":_sixBogu2Com,
            "onCompleteParams":[bg2]
         });
         tw3 = TweenLite.to(_sixBogu3,(_sixBogu3.y - _boguTypePoints[2].y) / 375,{
            "y":_boguTypePoints[2].y,
            "ease":Linear.easeNone,
            "onComplete":_sixBogu3Com,
            "onCompleteParams":[bg3]
         });
      }
      
      private function reSetBogu() : void
      {
         fastestLast1 = 3;
         fastestLast2 = 5;
         fastestLast3 = 8;
         tSpeed1 = 0.4;
         tSpeed2 = 0.4;
         tSpeed3 = 0.4;
         var _loc1_:* = false;
         _finallyFireWork.visible = _loc1_;
         _loc1_ = _loc1_;
         _finallyLight.visible = _loc1_;
         _loc1_ = _loc1_;
         _shine3.visible = _loc1_;
         _loc1_ = _loc1_;
         _shine2.visible = _loc1_;
         _loc1_ = _loc1_;
         _shine1.visible = _loc1_;
         _loc1_ = _loc1_;
         _tenfoldMc.visible = _loc1_;
         _loc1_ = _loc1_;
         _fivefoldMc.visible = _loc1_;
         _tripleMc.visible = _loc1_;
         _shine1.gotoAndStop(1);
         _shine2.gotoAndStop(1);
         _shine3.gotoAndStop(1);
      }
      
      private function _sixBogu1Com(bg:int) : void
      {
         tw1.kill();
         _sixBogu1.y = _boguTypePoints[0].y;
         tSpeed1 = Number(tSpeed1.toFixed(3));
         if(fastestLast1 > 0 && tSpeed1 > 0.3)
         {
            tSpeed1 = tSpeed1 - 0.05;
         }
         else if(fastestLast1 > 0 && tSpeed1 == 0.3)
         {
            fastestLast1 = Number(fastestLast1) - 1;
            _sixBogu1.gotoAndStop(2);
         }
         else if(tSpeed1 < 0.4)
         {
            tSpeed1 = tSpeed1 + 0.05;
            _sixBogu1.gotoAndStop(1);
         }
         tSpeed1 = Number(tSpeed1.toFixed(3));
         if(fastestLast1 == 0 && tSpeed1 == 0.4)
         {
            tw1 = TweenLite.to(_sixBogu1,tSpeed1 + 0.1,{
               "y":_boguTypePoints[bg].y,
               "ease":Back.easeOut
            });
         }
         else
         {
            tw1 = TweenLite.to(_sixBogu1,tSpeed1,{
               "y":_boguTypePoints[2].y,
               "ease":Linear.easeNone,
               "onComplete":_sixBogu1Com,
               "onCompleteParams":[bg]
            });
         }
      }
      
      private function _sixBogu2Com(bg:int) : void
      {
         tw2.kill();
         _sixBogu2.y = _boguTypePoints[0].y;
         tSpeed2 = Number(tSpeed2.toFixed(3));
         if(fastestLast2 > 0 && tSpeed2 > 0.3)
         {
            tSpeed2 = tSpeed2 - 0.05;
         }
         else if(fastestLast2 > 0 && tSpeed2 == 0.3)
         {
            fastestLast2 = Number(fastestLast2) - 1;
            _sixBogu2.gotoAndStop(2);
         }
         else if(tSpeed2 < 0.4)
         {
            tSpeed2 = tSpeed2 + 0.05;
            _sixBogu2.gotoAndStop(1);
         }
         tSpeed2 = Number(tSpeed2.toFixed(3));
         if(fastestLast2 == 0 && tSpeed2 == 0.4)
         {
            tw2 = TweenLite.to(_sixBogu2,tSpeed2 + 0.1,{
               "y":_boguTypePoints[bg].y,
               "ease":Back.easeOut
            });
         }
         else
         {
            tw2 = TweenLite.to(_sixBogu2,tSpeed2,{
               "y":_boguTypePoints[2].y,
               "ease":Linear.easeNone,
               "onComplete":_sixBogu2Com,
               "onCompleteParams":[bg]
            });
         }
      }
      
      private function _sixBogu3Com(bg:int) : void
      {
         tw3.kill();
         _sixBogu3.y = _boguTypePoints[0].y;
         tSpeed3 = Number(tSpeed3.toFixed(3));
         if(fastestLast3 > 0 && tSpeed3 > 0.3)
         {
            tSpeed3 = tSpeed3 - 0.05;
         }
         else if(fastestLast3 > 0 && tSpeed3 == 0.3)
         {
            fastestLast3 = Number(fastestLast3) - 1;
            _sixBogu3.gotoAndStop(2);
         }
         else if(tSpeed3 < 0.4)
         {
            tSpeed3 = tSpeed3 + 0.05;
            _sixBogu3.gotoAndStop(1);
         }
         tSpeed3 = Number(tSpeed3.toFixed(3));
         if(fastestLast3 == 0 && tSpeed3 == 0.4)
         {
            tw3 = TweenLite.to(_sixBogu3,tSpeed3 + 0.1,{
               "y":_boguTypePoints[bg].y,
               "ease":Back.easeOut,
               "onComplete":__lotteryCom
            });
         }
         else
         {
            tw3 = TweenLite.to(_sixBogu3,tSpeed3,{
               "y":_boguTypePoints[2].y,
               "ease":Linear.easeNone,
               "onComplete":_sixBogu3Com,
               "onCompleteParams":[bg]
            });
         }
      }
      
      private function __lotteryCom() : void
      {
         _finallyLight.visible = true;
         if(_sixBogu1.y == _sixBogu2.y)
         {
            var _loc2_:Boolean = true;
            _shine2.visible = _loc2_;
            _shine1.visible = _loc2_;
            _shine1.gotoAndPlay(1);
            _shine2.gotoAndPlay(1);
         }
         if(_sixBogu1.y == _sixBogu3.y)
         {
            _loc2_ = true;
            _shine3.visible = _loc2_;
            _shine1.visible = _loc2_;
            _shine1.gotoAndPlay(1);
            _shine3.gotoAndPlay(1);
         }
         if(_sixBogu2.y == _sixBogu3.y)
         {
            _loc2_ = true;
            _shine3.visible = _loc2_;
            _shine2.visible = _loc2_;
            _shine2.gotoAndPlay(1);
            _shine3.gotoAndPlay(1);
         }
         var lm:int = _multiple;
         if(lm > 1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.ddPlay.view.getMoney",lm));
            ChatManager.Instance.sysChatLinkYellow(LanguageMgr.GetTranslation("tank.ddPlay.view.getMoney",lm));
         }
         switch(int(lm) - 3)
         {
            case 0:
               _tripleMc.visible = true;
               break;
            default:
               _tripleMc.visible = true;
               break;
            case 2:
               _fivefoldMc.visible = true;
               break;
            default:
               _fivefoldMc.visible = true;
               break;
            default:
               _fivefoldMc.visible = true;
               break;
            default:
               _fivefoldMc.visible = true;
               break;
            default:
               _fivefoldMc.visible = true;
               break;
            case 7:
               _tenfoldMc.visible = true;
               _finallyFireWork.visible = true;
         }
         if(_stopUpBtn.visible == false)
         {
            _upBtn.enable = true;
            _selectedTxt.enable = true;
         }
         isPlaying = false;
         _scoreTxt.text = DDPlayManaer.Instance.DDPlayScore.toString();
         _coinsTxt.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(201310).toString();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      override public function dispose() : void
      {
         InviteManager.Instance.enabled = true;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_sixBogu1);
         _sixBogu1 = null;
         ObjectUtils.disposeObject(_sixBogu2);
         _sixBogu2 = null;
         ObjectUtils.disposeObject(_sixBogu3);
         _sixBogu3 = null;
         ObjectUtils.disposeObject(_boguMaskSp1);
         _boguMaskSp1 = null;
         ObjectUtils.disposeObject(_boguMaskSp2);
         _boguMaskSp2 = null;
         ObjectUtils.disposeObject(_boguMaskSp3);
         _boguMaskSp3 = null;
         ObjectUtils.disposeObject(_boguMask1);
         _boguMask1 = null;
         ObjectUtils.disposeObject(_boguMask2);
         _boguMask2 = null;
         ObjectUtils.disposeObject(_boguMask3);
         _boguMask3 = null;
         ObjectUtils.disposeObject(_tripleMc);
         _tripleMc = null;
         ObjectUtils.disposeObject(_fivefoldMc);
         _fivefoldMc = null;
         ObjectUtils.disposeObject(_tenfoldMc);
         _tenfoldMc = null;
         ObjectUtils.disposeObject(_triple);
         _triple = null;
         ObjectUtils.disposeObject(_fivefold);
         _fivefold = null;
         ObjectUtils.disposeObject(_tenfold);
         _tenfold = null;
         ObjectUtils.disposeObject(_lights);
         _lights = null;
         ObjectUtils.disposeObject(_shine1);
         _shine1 = null;
         ObjectUtils.disposeObject(_shine2);
         _shine2 = null;
         ObjectUtils.disposeObject(_shine3);
         _shine3 = null;
         ObjectUtils.disposeObject(_titleLight);
         _titleLight = null;
         ObjectUtils.disposeObject(_finallyLight);
         _finallyLight = null;
         ObjectUtils.disposeObject(_finallyFireWork);
         _finallyFireWork = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         ObjectUtils.disposeObject(_stopUpBtn);
         _stopUpBtn = null;
         ObjectUtils.disposeObject(_selectedTxt);
         _selectedTxt = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
         ObjectUtils.disposeObject(_explameTxt);
         _explameTxt = null;
         ObjectUtils.disposeObject(_coinsTxt);
         _coinsTxt = null;
         ObjectUtils.disposeObject(_coinsTxt);
         _coinsTxt = null;
         ObjectUtils.disposeObject(_exchangeFrame);
         _exchangeFrame = null;
         super.dispose();
      }
   }
}
