// products/phone/src/main/ets/pages/Index.ets
import { BreakpointSystem, BreakpointConstants } from '@app/common';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = 'Hello HarmonyOS';
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_SM;
  private breakpointSystem: BreakpointSystem = new BreakpointSystem();

  aboutToAppear(): void {
    // 注册断点监听
    this.breakpointSystem.register();
  }

  aboutToDisappear(): void {
    // 注销断点监听
    this.breakpointSystem.unregister();
  }

  build() {
    Column({ space: 20 }) {
      // 响应式标题 - 根据断点调整字体大小
      Text(this.message)
        .fontSize(this.getResponsiveFontSize())
        .fontColor(Color.Black)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 50 })

      // 响应式按钮布局
      this.buildResponsiveButtons()

      // 响应式网格布局
      this.buildResponsiveGrid()

      // 设备能力检测示例
      this.buildDeviceSpecificContent()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding(20)
  }

  // 根据断点返回字体大小
  private getResponsiveFontSize(): number {
    switch (this.currentBreakpoint) {
      case BreakpointConstants.BREAKPOINT_XS:
        return 16;
      case BreakpointConstants.BREAKPOINT_SM:
        return 18;
      case BreakpointConstants.BREAKPOINT_MD:
        return 20;
      case BreakpointConstants.BREAKPOINT_LG:
        return 24;
      default:
        return 18;
    }
  }

  // 响应式按钮构建器
  @Builder
  private buildResponsiveButtons() {
    GridRow({
      columns: this.getResponsiveColumns(),
      gutter: { x: 12, y: 12 }
    }) {
      GridCol({ span: { xs: 2, sm: 1, md: 1, lg: 1 } }) {
        Button('LED控制')
          .width('100%')
          .height(50)
          .fontSize(16)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Led'
            });
          })
      }

      GridCol({ span: { xs: 2, sm: 1, md: 1, lg: 1 } }) {
        Button('设置')
          .width('100%')
          .height(50)
          .fontSize(16)
          .onClick(() => {
            // 导航到设置页面
          })
      }
    }
    .width('100%')
    .margin({ top: 30 })
  }

  // 响应式网格布局
  @Builder
  private buildResponsiveGrid() {
    const items = [1, 2, 3, 4, 5, 6];

    GridRow({
      columns: this.getResponsiveColumns(),
      gutter: { x: 16, y: 16 },
      breakpoints: {
        value: ['320vp', '600vp', '840vp'],
        reference: mediaquery.BreakpointsReference.WindowSize
      }
    }) {
      ForEach(items, (item: number) => {
        GridCol({
          span: this.getGridColSpan(),
          offset: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 0 : 0
        }) {
          Column() {
            Text(`项目 ${item}`)
              .fontSize(14)
              .fontColor(Color.White)
          }
          .width('100%')
          .height(100)
          .backgroundColor(0x007DFF)
          .borderRadius(8)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
      })
    }
    .width('100%')
    .margin({ top: 30 })
  }

  // 设备特定内容
  @Builder
  private buildDeviceSpecificContent() {
    // 检测设备能力
    if (DeviceCapability.hasFeature('SystemCapability.Communication.Bluetooth.Core')) {
      Column() {
        Text('本设备支持蓝牙功能')
          .fontSize(14)
          .fontColor(Color.Green)
          .margin({ top: 20 })
      }
    }

    // 根据设备类型显示不同内容

    tSize(14)
            .fontColor(Color.Blue)
        }
        .margin({ top: 20 })
      },
      () => {
        // 平板设备特定内容
        Column() {
          Text('平板优化界面 - 显示更多内容')
            .fontSize(16)
            .fontColor(Color.Orange)

          // 平板特有功能
          Button('分屏模式')
            .width(200)
            .margin({ top: 10 })
        }
        .margin({ top: 20 })
      }
    );
  }

  // 获取响应式列数
  private getResponsiveColumns(): GridRowColumnOption {
    return {
      xs: 2,  // 超小屏：2列
      sm: 3,  // 小屏：3列
      md: 4,  // 中屏：4列
      lg: 6   // 大屏：6列
    };
  }

  // 获取网格列跨度
  private getGridColSpan(): GridColColumnOption {
    return {
      xs: 1,  // 超小屏：占1列
      sm: 1,  // 小屏：占1列
      md: 1,  // 中屏：占1列
      lg: 2   // 大屏：占2列
    };
  }
}