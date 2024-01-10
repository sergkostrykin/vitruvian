import SwiftUI
import _AVKit_SwiftUI

struct ExerciseDetail: View {
    
    @StateObject var vm: ExerciseDetailViewModel
        
    var body: some View {
        
        VStack(alignment: .leading) {
            if let player = vm.player {
                VideoPlayer(player: player)
                    .onAppear() {
                        player.play()
                    }
                    .onDisappear() {
                        player.pause()
                    }
                    .frame(height: 220)
            }
            
            if vm.isEquipmentSectionEnabled {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(vm.equipmentSectionTitle)
                                .font(.headline)
                                .padding([.leading, .trailing, .top], 20)
                            Text(vm.equipmentSectionContent)
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                                .padding([.leading, .trailing, .bottom], 20)
                        }
                        Spacer()
                    }
                }
                .background(Color.white)
                .cornerRadius(16)
                .padding()
            }
            
            if vm.isMusclesSectionEnabled {
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(vm.musclesSectionTitle)
                                .font(.headline)
                                .padding([.leading, .trailing, .top], 20)
                                
                            Text(vm.musclesSectionContent)
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                                .padding([.leading, .trailing, .bottom], 20)
                        }
                        Spacer()
                    }
                }
                .background(Color.white)
                .cornerRadius(16)
                .padding()
                
                Spacer()
            }
            
            if vm.isDesciptionSectionEnabled {
                VStack(alignment: .leading) {
                    HStack {
                        VStack {
                            HStack {
                                Text(vm.descriptionSectionTitle)
                                    .font(.headline)
                                    .padding([.leading, .trailing, .top], 20)

                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        vm.isDescriptionExpanded.toggle()
                                    }
                                }) {
                                    ZStack {
                                        Image(systemName: vm.expandButtonName)
                                    }
                                    .frame(width: 40, height: 40)
                                }
                            }
                            if vm.isDescriptionExpanded {
                                Text(vm.descriptionSectionContent)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding([.leading, .trailing, .bottom], 20)

                            } else {
                                Text(vm.descriptionSectionContent)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .padding([.leading, .trailing, .bottom], 20)
                                    .lineLimit(2)
                            }
                            Spacer()
                        }
                    }
                }
                
                .background(Color.white)
                .cornerRadius(16)
                .padding()
                
                Spacer()
            }
        }
        .background(Color.gray.opacity(0.15))
        Spacer()
        // TODO: - This detail view should show:
        //  - A video player, only for the first video in the exercise videos array
        //  - A section for the exercise’s muscle groups
        //  - A section for the exercise’s equipment
        //  - A collapsible section for the exercise’s description, if it exists
    }
}
