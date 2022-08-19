import * as Types from '../types';

import gql from 'graphql-tag';
import * as VueApolloComposable from '@vue/apollo-composable';
import * as VueCompositionApi from 'vue';
export type ReactiveFunction<TParam> = () => TParam;

export const ObjectManagerFrontendAttributesDocument = gql`
    query objectManagerFrontendAttributes($object: EnumObjectManagerObjects!, $filterScreen: String) {
  objectManagerFrontendAttributes(object: $object, filterScreen: $filterScreen) {
    name
    display
    dataType
    dataOption
  }
}
    `;
export function useObjectManagerFrontendAttributesQuery(variables: Types.ObjectManagerFrontendAttributesQueryVariables | VueCompositionApi.Ref<Types.ObjectManagerFrontendAttributesQueryVariables> | ReactiveFunction<Types.ObjectManagerFrontendAttributesQueryVariables>, options: VueApolloComposable.UseQueryOptions<Types.ObjectManagerFrontendAttributesQuery, Types.ObjectManagerFrontendAttributesQueryVariables> | VueCompositionApi.Ref<VueApolloComposable.UseQueryOptions<Types.ObjectManagerFrontendAttributesQuery, Types.ObjectManagerFrontendAttributesQueryVariables>> | ReactiveFunction<VueApolloComposable.UseQueryOptions<Types.ObjectManagerFrontendAttributesQuery, Types.ObjectManagerFrontendAttributesQueryVariables>> = {}) {
  return VueApolloComposable.useQuery<Types.ObjectManagerFrontendAttributesQuery, Types.ObjectManagerFrontendAttributesQueryVariables>(ObjectManagerFrontendAttributesDocument, variables, options);
}
export function useObjectManagerFrontendAttributesLazyQuery(variables: Types.ObjectManagerFrontendAttributesQueryVariables | VueCompositionApi.Ref<Types.ObjectManagerFrontendAttributesQueryVariables> | ReactiveFunction<Types.ObjectManagerFrontendAttributesQueryVariables>, options: VueApolloComposable.UseQueryOptions<Types.ObjectManagerFrontendAttributesQuery, Types.ObjectManagerFrontendAttributesQueryVariables> | VueCompositionApi.Ref<VueApolloComposable.UseQueryOptions<Types.ObjectManagerFrontendAttributesQuery, Types.ObjectManagerFrontendAttributesQueryVariables>> | ReactiveFunction<VueApolloComposable.UseQueryOptions<Types.ObjectManagerFrontendAttributesQuery, Types.ObjectManagerFrontendAttributesQueryVariables>> = {}) {
  return VueApolloComposable.useLazyQuery<Types.ObjectManagerFrontendAttributesQuery, Types.ObjectManagerFrontendAttributesQueryVariables>(ObjectManagerFrontendAttributesDocument, variables, options);
}
export type ObjectManagerFrontendAttributesQueryCompositionFunctionResult = VueApolloComposable.UseQueryReturn<Types.ObjectManagerFrontendAttributesQuery, Types.ObjectManagerFrontendAttributesQueryVariables>;